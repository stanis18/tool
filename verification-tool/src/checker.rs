use std::{convert::TryInto, fs::{File}, io::{Read, Write}, path::Path};

use crate::parser::{Implementation, Specification, FunctionImplementation, FunctionSpecification,VariableDeclaration,
    FunctionSignature,FunctionImplementationContractName,StructDefinition, VariableDeclarationAndContractName, EventDefinition};

use crate::proxy::{get_imports_facet, get_imports_facet_base_contracts, get_parameters_type_name_paramts, 
                   get_state_mutability, get_parameters_type_name_return};


pub fn check_synctatic_conformance(spec: &Specification, imp: &Implementation, evolution: bool) -> Result<(), String> {
   
    // for i in 0..spec.variables.len() {
        
    //     let compatible_variable = search_variables_declaration(&imp, &spec.variables[i]).unwrap();
    //     if !compatible_variable {
    //         return Err("Incompatible variables between the specification and implementation contracts".to_owned());
    //     }
    // }   

    for i in 0..spec.functions.len() {
        
        if evolution && spec.functions[i].signature.kind == "constructor" { continue; }
        let compatible_function = search_function_implementation(&imp, &spec.functions[i].signature).unwrap();
        
        if !compatible_function {

            println!("spec.functions {:?}", &spec.functions[i].signature);

            for i in 0..imp.functions.len() { 
                println!("imp.function {:?}", &imp.functions[i].signature);
            }

            return Err("Incompatible functions between the specification and implementation contracts".to_owned());
        }
    }

    let mut impl_func :Vec<FunctionImplementation> = Vec::new();
    get_function_implementation(&imp, &mut impl_func);

    for i in 0..impl_func.len() {
  
        if evolution && impl_func[i].signature.kind == "constructor" {
            return Err("The contract's implementation cannot have constructor".to_owned());
        }
        let func_spec = get_func_spec(&impl_func[i], &spec.functions)?;

        if func_spec.signature != impl_func[i].signature {

            return Err("Incompatible functions between the specification and implementation contracts".to_owned());
        }
    }
    Ok(())
}

pub fn get_function_implementation(imp: &Implementation, func: &mut Vec<FunctionImplementation>) {
    func.append( &mut imp.functions.clone());
    //verificar se quebrou
    // for i in 0..imp.contracts_inherited.len() {
    //     get_function_implementation(&imp.contracts_inherited[i], func);
    // }
}

pub fn get_variables_implementation(imp: &Implementation, variables: &mut Vec<VariableDeclaration>) {
    variables.append(&mut imp.variables.clone());
    //verificar se quebrou
    // for i in 0..imp.contracts_inherited.len() {
    //     get_variables_implementation(&imp.contracts_inherited[i], variables);
    // }
}


pub fn get_all_variables_implementation(imp: &Implementation, variables: &mut Vec<VariableDeclarationAndContractName>) {

    for i in 0..imp.variables.len() {
        
        variables.push( VariableDeclarationAndContractName {
            contract_name: imp.contract_name.to_owned(),
            variable: imp.variables[i].clone(),
        })
    }

    

    // variables.append(&mut imp.variables.clone());
    for i in 0..imp.contracts_inherited.len() {
        get_all_variables_implementation(&imp.contracts_inherited[i], variables);
    }
}


fn search_function_implementation(imp: &Implementation, funcion_sig: &FunctionSignature) -> Result<bool,String> {
    for i in 0..imp.functions.len() { 
        if &imp.functions[i].signature == funcion_sig {
           return Ok(true);
        }
    }
    for i in 0..imp.contracts_inherited.len() {
        return search_function_implementation(&imp.contracts_inherited[i], funcion_sig);
    }
    Ok(false)
}

fn search_variables_declaration(imp: &Implementation, variable_decla: &VariableDeclaration) -> Result<bool,String> {
    for i in 0..imp.variables.len() { 
        if &imp.variables[i] == variable_decla {
           return Ok(true);
        }
    }
    for i in 0..imp.contracts_inherited.len() {
        return search_variables_declaration(&imp.contracts_inherited[i], variable_decla);
    }
    Ok(false)
}

fn get_function_implementation_contract(imp: &Implementation, func: &mut Vec<FunctionImplementationContractName>) {
    for i in 0..imp.functions.len() {
        let imp_contr = FunctionImplementationContractName {
            contract_name: imp.contract_name.clone(),
            function: imp.functions[i].clone()
        };
        func.push(imp_contr);
    }
    for i in 0..imp.contracts_inherited.len() {
        get_function_implementation_contract(&imp.contracts_inherited[i], func);
    }
}



// -------------------------------------



pub fn generate_merge_contract(spec: &Specification, imp: &Implementation, invariant: bool) -> Result <(), String>{
    
    let impl_path = Path::new("contracts/input").join(format!("{}.sol", imp.contract_name));
    let out_path = Path::new("contracts/input");

    let merge_file_name = format!("{}_{}.sol", "Merged_Contract", imp.contract_name);
    let merge_file_path = out_path.join(&merge_file_name).to_str().unwrap().to_string();
    let mut merge_file = File::create(merge_file_path.clone()).map_err( |_| {"Error creating merge".to_owned()}).unwrap();
    
    let model_merged_contract = format!("// SPDX-License-Identifier: MIT 
    \n pragma solidity >=0.4.22 <0.9.0;
    \n {} 
    \n contract Merged_Contract_{} {} {{
    \n    {}

    \n    {}

    \n    {}

    \n    {}
    
    \n }}", &get_imports_merge(&imp).unwrap(), &imp.contract_name, &get_imports_merge_base_contracts(&imp).unwrap(), 
            get_variables_merge_contract(&imp).unwrap(), specification_struct_to_string(&imp.structs).unwrap(),  
            specification_event_to_string(&imp.events).unwrap(),  get_functions_merge(&spec, &imp).unwrap());


    merge_file.write_all(&model_merged_contract.as_bytes()).unwrap();


    for i in 0..imp.contracts_inherited.len() {
        generate_merge_contract(&spec, &imp.contracts_inherited[i], false);
    }

    Ok(())

}


pub fn specification_event_to_string(list: &Vec<EventDefinition>) -> Result<String, String> {
    let mut list_event_string = Vec::new();
    for event_definition in list {
        list_event_string.push(event_definition.to_string());
    }
    let mut list_joined = list_event_string.join("\n");
    
    Ok(list_joined)
}


pub fn get_variables_merge_contract(imp: &Implementation) -> Result <String, ()> {
    
    let mut variables : Vec<String> = Vec::new();
    let mut impl_variables :Vec<VariableDeclaration> = Vec::new();
    get_variables_implementation(&imp, &mut impl_variables);

    if impl_variables.len() == 0 {
       return Ok("".to_string());    
    }

    for i in 0..impl_variables.len() {
        variables.push(format!("{} {}; \n", impl_variables[i].typ, impl_variables[i].name));
    }

    Ok(variables.join("\n"))
}

pub fn get_functions_merge(spec: &Specification,  imp: &Implementation) -> Result <String, ()> {

    let mut functions : Vec<String> = Vec::new();
    let mut impl_func :Vec<FunctionImplementation> = Vec::new();
    get_function_implementation(&imp, &mut impl_func);

    let impl_path = Path::new("contracts/input").join(format!("{}.sol", imp.contract_name));
    let mut impl_file = File::open(impl_path).map_err( |_| {"Error opening impl".to_owned()}).unwrap();

    let mut impl_variables :Vec<VariableDeclarationAndContractName> = Vec::new();
    get_all_variables_implementation(&imp, &mut impl_variables);
    
    
    for i in 0..impl_func.len() {

         functions.push( 
             format!(" /** \n * {} \n */ \n function {} ({}) {} {} {} {}",
             get_function_specification(&spec, &impl_func[i].signature).unwrap(), 
             impl_func[i].signature.name, get_parameters_type_name_paramts(&impl_func[i].signature.ins),
             impl_func[i].signature.visibility, 
             get_state_mutability(&impl_func[i].signature.state_mutability).unwrap(),
             get_parameters_type_name_return(&impl_func[i].signature.outs).unwrap(),
             impl_func[i].body_function ) 
         );
        }       
     
    Ok(functions.join("\n"))
}



fn get_function_specification(spec: &Specification, funcion_sig: &FunctionSignature) -> Result<String,String> {
    for i in 0..spec.functions.len() { 
        if &spec.functions[i].signature == funcion_sig {
           return Ok(spec.functions[i].spec.clone());
        }
    }
    
    Ok("".to_string())
}


pub fn get_imports_merge(imp: &Implementation) -> Result <String, ()> {
    
    let mut imports : Vec<String> = Vec::new(); //"{}.sol", imp.contract_name

    for i in 0..imp.imports.len() {
        imports.push(format!("import \"./Merged_Contract_{}.sol\";", imp.base_contracts[i].name));
    }

    Ok(imports.join("\n"))
}


pub fn get_imports_merge_base_contracts(imp: &Implementation) -> Result <String, ()> {
    
    let mut imports : Vec<String> = Vec::new();

    if imp.imports.len() == 0 {
        return Ok("".to_string());
    }

    for i in 0..imp.imports.len() {
        imports.push(format!("Merged_Contract_{}", imp.base_contracts[i].name));
    }

    Ok(format!("is {}", imports.join(",")))
}


// -------------------------------------



pub fn generate_merge_contract_old(spec: &Specification, imp: &Implementation, invariant: bool) -> Result <(), String>{

    let impl_path = Path::new("contracts/input").join(format!("{}.sol", imp.contract_name));
    let out_path = Path::new("contracts/input");

    let merge_file_name = format!("{}_{}.sol", "Merged_Contract", imp.contract_name);
    let merge_file_path = out_path.join(&merge_file_name).to_str().unwrap().to_string();
    let mut merge_file = File::create(merge_file_path.clone()).map_err( |_| {"Error creating merge".to_owned()}).unwrap();
    
    let mut impl_file = File::open(impl_path).map_err( |_| {"Error opening impl".to_owned()}).unwrap();
    let mut last_offset = 0;
    let mut buf = vec![0;imp.contract_definition.offset.try_into().unwrap()];

    if invariant {
        impl_file.read_exact(buf.as_mut_slice()).unwrap();
        merge_file.write_all(buf.as_slice()).unwrap();
        let x = format!("/** \n * {} \n */ \n", &spec.invariant);
        merge_file.write_all(x.as_bytes()).unwrap();
        last_offset = imp.contract_definition.offset;
    }

    for i in 0..imp.functions.len() {
        let func_impl = &imp.functions[i]; // get implementation
        let func_spec = get_func_spec_string(&func_impl, &spec.functions).unwrap();
        let buf_len = (func_impl.src.offset - last_offset).try_into().unwrap(); // buff size
        let mut buf = vec![0;buf_len]; // creating buff array
        last_offset = func_impl.src.offset;
        impl_file.read_exact(buf.as_mut_slice()).unwrap(); // reading from implementation file
        merge_file.write_all(buf.as_slice()).unwrap(); // writing in merge file
        let spec = format!("/** \n * {} \n */ \n", func_spec); // formating specification
        merge_file.write_all(spec.as_bytes()).unwrap(); // writing spec
    } 
    let mut rest = Vec::new();
    impl_file.read_to_end(&mut rest).unwrap();
    merge_file.write_all(rest.as_slice()).unwrap();


    for i in 0..imp.contracts_inherited.len() {
        generate_merge_contract(&spec, &imp.contracts_inherited[i], false);
    }
    Ok(())
}


pub fn get_func_spec(func_imp: &FunctionImplementation, spec_functions : &Vec<FunctionSpecification> ) ->  Result<FunctionSpecification, String >{
    for func in spec_functions {
       if func.signature.name == func_imp.signature.name {
        return Ok(func.clone());
       }
    }
    return Err("Missing Function".to_owned());
}


pub fn get_func_spec_string(func_imp: &FunctionImplementation, spec_functions : &Vec<FunctionSpecification> ) ->  Result<String, String >{
    for func in spec_functions {
       if func.signature.name == func_imp.signature.name {
        return Ok(func.spec.clone());
       }
    }
    return Ok("".to_owned());
}


pub fn specification_variable_to_string(list: &Vec<VariableDeclaration>) -> Result<String, String> {
    let mut list_variable_string = Vec::new();
    for variable_declaration in list {
        list_variable_string.push(variable_declaration.to_string());
    }
    let mut list_joined = list_variable_string.join(";");
    list_joined.push_str(";");
    Ok(list_joined)
}


pub fn specification_struct_to_string(list: &Vec<StructDefinition>) -> Result<String, String> {
    let mut list_struct_string = Vec::new();
    for struct_definition in list {
        list_struct_string.push(struct_definition.to_string());
    }
    let mut list_joined = list_struct_string.join("\n");
    
    Ok(list_joined)
}

pub fn specification_function_to_string(list: &Vec<FunctionSpecification>) -> Result<String, String> {
    let mut list_function_string = Vec::new();
    for function_declaration in list {
        list_function_string.push(function_declaration.to_string());
    }
    let list_joined = list_function_string.join("\n");
    Ok(list_joined)
}


#[derive(PartialEq, Debug,Clone)]
pub struct ClassificationRelation {
    pub variable_name: String,
    pub new_spec : bool
 }

pub fn filter_variable(declarations: &Vec<VariableDeclaration>, variable_name: &String ) -> Result<bool, String> {

    let mut s = variable_name.to_string();
    let len_withoutcrlf = s.trim_right().len();
    s.truncate(len_withoutcrlf);

    // let filtered_variable:Vec<_> = declarations.iter()
    //                             .filter(|variable| &variable.name == &s).collect();

    let filtered_variable:Vec<_> = declarations.iter()
                                .filter(|variable| s.starts_with(&variable.name) ).collect();
 
    Ok (filtered_variable.len() > 0)                            
}



pub fn classify_relations(spec_old: &Specification, spec_new: &mut Specification, relations: &Vec<String>) 
                                                -> Result<Vec<Vec<ClassificationRelation>>, String> {
    
    let mut list_relations_split: Vec<Vec<&str>> = Vec::new();

    for relation in relations {
        let relation_split: Vec<_> = relation.split("==").collect();
        list_relations_split.push(relation_split);
        // identify_variable_name(&mut relation.clone());
    }

    let mut list_relations: Vec<Vec<ClassificationRelation>> = Vec::new();
    
    for relation in list_relations_split {

        let mut list_rel: Vec<ClassificationRelation> = Vec::new();

        let result_old_first = filter_variable(&spec_old.variables, &relation.first().unwrap().to_string().trim().to_string());
        let result_old_last = filter_variable(&spec_old.variables, &relation.last().unwrap().to_string().trim().to_string());

        let result_new_first = filter_variable(&spec_new.variables, &relation.first().unwrap().to_string().trim().to_string());
        let result_new_last = filter_variable(&spec_new.variables, &relation.last().unwrap().to_string().trim().to_string());

        if result_old_first.unwrap() {
            
            let classification = ClassificationRelation {
                variable_name: relation.first().unwrap().to_string().trim().to_string(),
                new_spec: false,
            };
            list_rel.push(classification);
        }
        if result_new_first.unwrap() {
            let classification = ClassificationRelation {
                variable_name: relation.first().unwrap().to_string().trim().to_string(),
                new_spec: true,
            };
            list_rel.push(classification);
        }
        if result_old_last.unwrap() {
            let classification = ClassificationRelation {
                variable_name: relation.last().unwrap().to_string().trim().to_string(),
                new_spec: false,
            };
            list_rel.push(classification);
        }
        if result_new_last.unwrap() {
            let classification = ClassificationRelation {
                variable_name: relation.last().unwrap().to_string().trim().to_string(),
                new_spec: true,
            };
            list_rel.push(classification);
        }

        list_relations.push(list_rel);
    }

    Ok(list_relations)
}


pub fn generate_pre_conditions_relations(classified_relations: &Vec<Vec<ClassificationRelation>>) -> Result<Vec<String>, String>{
    
    let mut list_relations_split: Vec<String> = Vec::new();

    for classified_relation in classified_relations {

        if classified_relation.first().unwrap().new_spec && !classified_relation.last().unwrap().new_spec {
            list_relations_split.push( format!("@notice precondition nw.{} == od.{}", &classified_relation.first().unwrap().variable_name, 
                                                            &classified_relation.last().unwrap().variable_name) );
        } 

        if !classified_relation.first().unwrap().new_spec && classified_relation.last().unwrap().new_spec {
            list_relations_split.push(  format!("@notice precondition nw.{} == od.{}", &classified_relation.last().unwrap().variable_name, 
                                                            &classified_relation.first().unwrap().variable_name) );
        }
    }

    Ok(list_relations_split)
}


pub fn generate_pre_conditions_old_specification(spec_old: &Specification, function_name: &String ) -> Result<String, String> {
    
    let mut joined_string:String = "".to_string();

    for function in &spec_old.functions {

       if &function.signature.name == function_name {

        let mut spec_split: Vec<String> = function.spec.split(" ").map(|s| s.to_string()).collect();


          for i in 0..spec_split.len() {

                let filtered = filter_variable(&spec_old.variables, &spec_split[i].clone());

                if filtered.unwrap() {

                    spec_split[i] = format!("od.{}", &spec_split[i]).to_owned();
                } else if &spec_split[i] == "postcondition" {
                    
                    spec_split[i] = "precondition".to_string();
                }
          }
          joined_string = spec_split.join(" ");
       } 
    }

    Ok(joined_string)
}

pub fn generate_relations(spec_old: &Specification, spec_new: &mut Specification, relations: &Vec<String>) {
    
    let classified_relations = classify_relations(&spec_old, spec_new, &relations).unwrap();

    let pre_conditions = generate_pre_conditions_relations(&classified_relations).unwrap();

    for i in 0..spec_new.functions.len() {

        let mut spec_split: Vec<String> = spec_new.functions[i].spec.split(" ").map(|s| s.to_string()).collect();

        for i in 0..spec_split.len() {

            let filtered = filter_variable(&spec_new.variables, &spec_split[i].clone());

            if filtered.unwrap() {
                spec_split[i] = format!("nw.{}", &spec_split[i]).to_owned();
            }
        }

        let full_spec = format!("{} \n {} \n {}", pre_conditions.join(" \n"), 
        generate_pre_conditions_old_specification(&spec_old, &spec_new.functions[i].signature.name ).unwrap(), spec_split.join(" "));
        
        spec_new.functions[i].spec = full_spec;
    }
}


pub fn generate_refinement_contract(spec_old: &Specification, spec_new: &mut Specification, relations: &Vec<String>) -> Result <(), String>{

    let out_path = Path::new("contracts/input");
   
    let refinement_contract_name = format!("{}.sol", "Refinement_Contract");
    let refinement_file_path = out_path.join(&refinement_contract_name).to_str().unwrap().to_string();
    let mut refinement_file = File::create(refinement_file_path.clone()).map_err( |_| {"Error creating relations".to_owned()}).unwrap();

    generate_relations(&spec_old, spec_new, &relations);


    let model_contract = format!("// SPDX-License-Identifier: MIT 
    \n pragma solidity >=0.4.22 <0.9.0; 
    \n contract Refinement_Contract {{
    \n struct StateOld {{ {}  }}
    \n struct StateNew {{ {}  }}
    \n {}
    \n {}
    \n StateOld od;
    \n StateOld od_old;
    \n StateNew nw;
    \n StateNew nw_old;
    \n {}
    \n }}", specification_variable_to_string(&spec_old.variables).unwrap(), 
            specification_variable_to_string(&spec_new.variables).unwrap(),
            specification_struct_to_string(&spec_old.structs).unwrap(),
            specification_struct_to_string(&spec_new.structs).unwrap(), 
            specification_function_to_string(&spec_new.functions).unwrap());

    refinement_file.write_all(&model_contract.as_bytes()).unwrap();

    Ok(())
}


pub fn get_equivalent(variable: &String, classified_relations: &Vec<Vec<ClassificationRelation>>) -> Result<String, String>{

    for relation in classified_relations {

        if &relation.first().unwrap().variable_name == variable {
            return Ok(relation.last().unwrap().variable_name.clone());
        }

        if &relation.last().unwrap().variable_name == variable {
            return Ok(relation.first().unwrap().variable_name.clone());
        }
    }

    return Ok("".to_owned());
}



pub fn generate_old_contract(imp_old: &Implementation, spec_old: &mut Specification, spec_new: &mut Specification, relations: &Vec<String>) -> Result <(), String> {

    let classified_relations = classify_relations(&spec_old, spec_new, &relations).unwrap();

    for i in 0..spec_new.functions.len() {

        let mut spec_split: Vec<String> = spec_new.functions[i].spec.split(" ").map(|s| s.to_string()).collect();

        for i in 0..spec_split.len() {

            let filtered = filter_variable(&spec_new.variables, &spec_split[i].clone());

            if filtered.unwrap() {

               let equiv = get_equivalent(&spec_split[i], &classified_relations).unwrap();

               if equiv != "".to_string() {
                 spec_split[i] = equiv;
               }
            }
        }

        spec_new.functions[i].spec = spec_split.join(" ");
    }

    generate_merge_contract(&spec_new, &imp_old, true);

    Ok(())
}