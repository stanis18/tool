use crate::parser::{Implementation,VariableDeclaration};
use std::fs::File;
use std::convert::TryInto;
use std::str;
use std::{path::Path};
use std::io::{prelude::*, SeekFrom, Read};
use crate::util::{write_file};
use crate::checker::{get_function_implementation,get_variables_implementation, get_all_variables_implementation};
use crate::parser::{FunctionImplementation, VariableDeclarationAndContractName};
use regex::Regex;



pub fn generate_facet (imp: &Implementation) {

    config_facet(&imp);
    
    for i in 0..imp.contracts_inherited.len() {
        generate_facet(&imp.contracts_inherited[i]);
    }
}


pub fn config_facet (imp: &Implementation) {

    let out_path = Path::new("contracts/input");
    let facet_contract_name = format!("{}_{}.sol", "Facet_Contract", imp.contract_name);
    let facet_file_path = out_path.join(&facet_contract_name).to_str().unwrap().to_string();
    let mut facet_file = std::fs::File::create(facet_file_path.clone()).map_err( |_| {"Error creating relations".to_owned()}).unwrap();

    let model_facet = format!("// SPDX-License-Identifier: MIT 
    \n pragma solidity >=0.4.22 <0.9.0;
    \n {} 
    \n contract Facet_Contract_{} {} {{
    \n bytes32 constant FACET_STORAGE_POSITION_{} = keccak256({:?});

    \n {}

    \n function getStorage_{}() internal pure returns (FacetStorage_{} storage storageStruct) {{
        bytes32 position = FACET_STORAGE_POSITION_{};
        assembly {{
            storageStruct_slot := position
            }}
        }}

    \n {}
    
    \n }}", &get_imports_facet(&imp).unwrap(), &imp.contract_name, &get_imports_facet_base_contracts(&imp).unwrap(), 
            &imp.contract_name, format!("{}.storage", &imp.contract_name), &get_variables_facet(&imp).unwrap(), 
            &imp.contract_name, &imp.contract_name, &imp.contract_name, &get_functions_facet(&imp).unwrap());

    facet_file.write_all(&model_facet.as_bytes()).unwrap();
       
}


pub fn get_functions_facet(imp: &Implementation) -> Result <String, ()> {

    let mut functions : Vec<String> = Vec::new();
    let mut impl_func :Vec<FunctionImplementation> = Vec::new();
    get_function_implementation(&imp, &mut impl_func);

    let impl_path = Path::new("contracts/input").join(format!("{}.sol", imp.contract_name));
    let mut impl_file = File::open(impl_path).map_err( |_| {"Error opening impl".to_owned()}).unwrap();

    let mut impl_variables :Vec<VariableDeclarationAndContractName> = Vec::new();
    get_all_variables_implementation(&imp, &mut impl_variables);
    
    
    for i in 0..impl_func.len() {

        for j in 0..impl_variables.len() {

            let replacement_word = format!("getStorage_{}().{}", &impl_variables[j].contract_name, &impl_variables[j].variable.name);

            let pattern = format!(r"\b{}\b", regex::escape(&impl_variables[j].variable.name));
                
            let re = Regex::new(&pattern).expect("Invalid regex pattern");
            let replaced_text = re.replace_all(&impl_func[i].body_function, replacement_word);
                
            impl_func[i].body_function = replaced_text.to_string();
        }

         functions.push( 
             format!("function {} ({}) {} {} {} {}", 
             impl_func[i].signature.name, get_parameters_type_name_paramts(&impl_func[i].signature.ins),
             impl_func[i].signature.visibility, 
             get_state_mutability(&impl_func[i].signature.state_mutability).unwrap(),
             get_parameters_type_name_return(&impl_func[i].signature.outs).unwrap(),
             impl_func[i].body_function ) 
         );
        }       
     
    Ok(functions.join("\n"))
}


pub fn get_variables_facet(imp: &Implementation) -> Result <String, ()> {
    
    let mut variables : Vec<String> = Vec::new();
    let mut impl_variables :Vec<VariableDeclaration> = Vec::new();
    get_variables_implementation(&imp, &mut impl_variables);

    if impl_variables.len() == 0 {
       return Ok("".to_string());    
    }

    variables.push(format!("struct FacetStorage_{} {{", imp.contract_name ));

    for i in 0..impl_variables.len() {
        variables.push(format!("{} {}; \n", impl_variables[i].typ, impl_variables[i].name));
    }

    variables.push("}".to_string());

    Ok(variables.join("\n"))
}


pub fn get_imports_facet(imp: &Implementation) -> Result <String, ()> {
    
    let mut imports : Vec<String> = Vec::new();

    for i in 0..imp.imports.len() {
        imports.push(format!("import {:?};", imp.imports[i].file));
    }

    Ok(imports.join("\n"))
}


pub fn get_imports_facet_base_contracts(imp: &Implementation) -> Result <String, ()> {
    
    let mut imports : Vec<String> = Vec::new();

    if imp.imports.len() == 0 {
        return Ok("".to_string());
    }

    for i in 0..imp.imports.len() {
        imports.push(format!("{}", imp.base_contracts[i].name));
    }

    Ok(format!("is {}", imports.join(",")))
}


pub fn get_variables_proxy(spec: &Implementation) -> Result <String, ()> {
    
    let mut variables : Vec<String> = Vec::new();
    let mut impl_variables :Vec<VariableDeclaration> = Vec::new();
    get_variables_implementation(&spec, &mut impl_variables);

    for i in 0..impl_variables.len() {
        variables.push(format!("{} {} {}; \n", impl_variables[i].typ, impl_variables[i].visibility, impl_variables[i].name));
    }
    Ok(variables.join("\n"))
}

pub fn get_functions_proxy(imp: &Implementation) -> Result <String, ()> {

    let mut functions : Vec<String> = Vec::new();
    let mut impl_func :Vec<FunctionImplementation> = Vec::new();
    get_function_implementation(&imp, &mut impl_func);
    
    for i in 0..impl_func.len() {
       if impl_func[i].signature.kind == "function" {
            functions.push( 
                format!("function {} ({}) {} {} {} {{
                    (bool success, bytes memory bytesAnswer) = implementation.delegatecall(
                        abi.encodeWithSignature(\"{}({})\" {}));
                    require(success);
                    {}
                }}", impl_func[i].signature.name, get_parameters_type_name_paramts(&impl_func[i].signature.ins),
                impl_func[i].signature.visibility, 
                get_state_mutability(&impl_func[i].signature.state_mutability).unwrap(),
                get_parameters_type_name_return(&impl_func[i].signature.outs).unwrap(),
                impl_func[i].signature.name,
                get_parameters_type(&impl_func[i].signature.ins), get_parameters_name(&impl_func[i].signature.ins).unwrap(),
                get_parameters_type_return(&impl_func[i].signature.outs).unwrap() ) 
            );
       }       
    }
    Ok(functions.join("\n"))
}

pub fn get_state_mutability(state_mutability: &String)  -> Result <String, ()> {
    if state_mutability != "payable"{
        return Ok("".to_string());
    }
    Ok(state_mutability.to_owned())
}

pub fn get_parameters_type_return(ret: &Vec<VariableDeclaration>) -> Result <String, ()> {
    let mut src_info : Vec<String> = Vec::new();
    if ret.len() > 0 {
        for par in ret {
            src_info.push(format!("{}", par.typ));
        }
        return Ok(format!(" return abi.decode(bytesAnswer, ( {} ) );", src_info.join(",")).to_string());
    }
    Ok("".to_string())
}

pub fn get_parameters_type_name_return(ret: &Vec<VariableDeclaration>) -> Result <String, ()> {
    let mut src_info : Vec<String> = Vec::new();
    
    if ret.len() > 0 {
        for par in ret {
            if par.storage_location == "default" {
                src_info.push(format!("{} {}", par.typ, par.name));
            } else { 
                src_info.push(format!("{} {} {}", par.typ, par.storage_location, par.name));
            }
        }
        return Ok(format!(" returns ( {} )", src_info.join(",")).to_string());
    }
    Ok("".to_string())
}

pub fn get_parameters_type_name_paramts(ins: &Vec<VariableDeclaration>) -> String {
    let mut src_info : Vec<String> = Vec::new();
    for par in ins {
        if par.storage_location == "default" {
            src_info.push(format!("{} {}", par.typ, par.name));
        } else { 
            src_info.push(format!("{} {} {}", par.typ, par.storage_location, par.name));
        }
    }
    return src_info.join(",");
}

pub fn get_parameters_type(ins: &Vec<VariableDeclaration>) -> String {
    let mut src_info : Vec<String> = Vec::new();
    for par in ins {
        src_info.push(par.typ.to_string());
    }
    return src_info.join(",");
}

pub fn get_parameters_name(ins: &Vec<VariableDeclaration>) -> Result <String, ()> {
    
    if ins.len() > 0 {
        let mut src_info : Vec<String> = Vec::new();
        for par in ins {
            src_info.push(par.name.to_string());
        }
        return Ok(format!(",{}", src_info.join(",")));
    }
    Ok("".to_string())
}