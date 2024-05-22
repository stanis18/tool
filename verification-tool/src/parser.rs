use std::{fs::File, path::Path};
use serde_json::{Map, Value as JsonValue};
use serde::{Deserialize, Serialize};
use crate::checker::{specification_variable_to_string};
use crate::proxy::{get_parameters_type_name_paramts};
use std::io::{prelude::*, SeekFrom, Read, BufReader };

#[derive(Serialize, Deserialize, Debug,Clone)]
#[serde(rename_all = "camelCase")]
struct SpecArtifact {
    nodes: (JsonValue, JsonValue),
}

#[derive(Debug,Clone)]
pub struct Specification {
    pub contract_name: String,
    pub invariant: String,
    pub variables: Vec<VariableDeclaration>,
    pub functions: Vec<FunctionSpecification>,
    pub structs: Vec<StructDefinition>,
}

#[derive(Debug,Clone)]
pub struct FunctionSpecification {
    pub spec: String,
    pub signature: FunctionSignature,   
}

impl ToString for FunctionSpecification {
    fn to_string(&self) -> String {
        format!("/** \n * @notice precondition true \n * @notice postcondition true */ \n function {}_pre () {} {{}} \n
        /** \n {} \n */ \n function {}_post ({}) {} {{}}", 
        self.signature.name, self.signature.visibility, self.spec, self.signature.name, 
        functions_parameters_and_returns(&self.signature.ins, &self.signature.outs).unwrap(), 
        self.signature.visibility)
    }
}

pub fn functions_parameters_and_returns(ins: &Vec<VariableDeclaration>, outs: &Vec<VariableDeclaration>) -> Result<String, String> {
    
    let mut list_variable_string = Vec::new();
    
    for variable_declaration in ins {
        list_variable_string.push(variable_declaration.to_string());
    }
    for variable_declaration in outs {
        list_variable_string.push(variable_declaration.to_string());
    }    
    let list_joined = list_variable_string.join(",");
    
    Ok(list_joined)
}


#[derive(PartialEq,Debug,Clone)]
pub struct FunctionSignature {
    pub kind: String,
    pub name: String,
    pub ins: Vec<VariableDeclaration>,
    pub outs: Vec<VariableDeclaration>,
    pub visibility : String,
    pub state_mutability : String,
}

#[derive(PartialEq, Debug,Clone,Serialize,Deserialize)]
pub struct VariableDeclaration {
    pub visibility: String,
    pub typ : String,
    pub name : String,
    pub storage_location : String,
}

impl ToString for VariableDeclaration {
    fn to_string(&self) -> String {
        format!("{} {}", self.typ, self.name)
    }
}

#[derive(Serialize, Deserialize, Debug,Clone)]
struct SolcArtifact {
    nodes: Vec<JsonValue>,
}

#[derive(Debug,Clone)]
pub struct Implementation {
    pub imports : Vec<ImportDefinition>,
    pub events: Vec<EventDefinition>,
    pub base_contracts : Vec<BaseContract>,
    pub contract_name: String,
    pub variables: Vec<VariableDeclaration>, 
    pub functions: Vec<FunctionImplementation>,
    pub contract_definition: Src,
    pub contracts_inherited : Vec<Implementation>,
    pub structs: Vec<StructDefinition>
 }

 #[derive(Debug,Clone)]
pub struct BaseContract {
    pub name: String
 }

 #[derive(Debug, Clone)]
 pub struct FunctionImplementation {
    pub signature: FunctionSignature,
    pub src: Src,
    pub body: Src,
    pub body_function: String,
}

#[derive(Debug,Clone)]
pub struct Src {
    pub offset: u64, // in bytes
    pub length: u64, // in bytes
    pub source_unit: u64, // identifier
}

#[derive(Debug, Clone)]
 pub struct FunctionImplementationContractName {
    pub contract_name: String,
    pub function: FunctionImplementation,
}


#[derive(PartialEq,Debug,Clone)]
pub struct StructDefinition {
    pub name : String,
    pub visibility : String,
    pub members: Vec<VariableDeclaration>,
}

impl ToString for StructDefinition {
    fn to_string(&self) -> String {
        format!("struct {} {{ {} }}", self.name, specification_variable_to_string(&self.members).unwrap())
    }
}

#[derive(PartialEq,Debug,Clone)]
pub struct EventDefinition {
    pub name : String,
    pub parameters: Vec<VariableDeclaration>,
}


impl ToString for EventDefinition {
    fn to_string(&self) -> String {
        format!("event {} ( {} )", self.name, get_parameters_type_name_paramts(&self.parameters))
    }
}


#[derive(Debug,Clone)]
pub struct VariableDeclarationAndContractName {
    pub contract_name: String,
    pub variable: VariableDeclaration,
}


#[derive(PartialEq,Debug,Clone)]
pub struct ImportDefinition {
    pub file : String,
}

pub fn parse_specification(spec_path : &Path) -> Result<Specification, String> {
    let file = File::open(spec_path).map_err( |_| {"Error opening json spec".to_owned()} )?;
    let reader = BufReader::new(file);
    
    let u : SpecArtifact = serde_json::from_reader(reader).map_err( |_| {"Error parsing json spec".to_owned()} )?;
    parse_pragma(&u.nodes.0)?;
    let spec = parse_spec_contract(&u.nodes.1)?;
    Ok(spec)
}

fn parse_pragma(pragma : &JsonValue) -> Result<(), String> {
    if let serde_json::Value::Object(map) = pragma {
        if let Some(serde_json::Value::String(s)) = map.get("nodeType") {
            if s == "PragmaDirective" {
                return Ok(())
            }
        }
    };
    Err("Expecting pragma directive".to_owned())
}

fn parse_spec_contract(contract : &JsonValue) -> Result<Specification, String> {
    let contract_elements = parse_node(contract, "ContractDefinition")?;

    let invariant = if let Some(serde_json::Value::String(invariant)) = contract_elements.get("documentation") {
        parse_invariant(invariant).unwrap()
    } else {
        "".to_string()
    };
    
    let (variables, functions, structs) = if let Some(serde_json::Value::Array(values)) = contract_elements.get("nodes") {
        (parse_variables(&values)?, parse_function_specifications(&values)?, parse_structs(&values)?)
    } else {
        return Err("Missing definitions".to_owned());
    };
    
    Ok(Specification {
        contract_name: contract.get("name").unwrap().to_string(),
        invariant,
        variables,
        functions,
        structs,
    })
}

fn parse_invariant(string: &str) -> Result<String,String> {
   
    for line in string.lines() {
        let line_without_whitespace: String = line.split_whitespace().collect();
        if !&line_without_whitespace.starts_with("@noticeinvariant") {
            return Err("Contract comment must only contain @notice invariant lines".to_owned());
        }
    }
    Ok(string.to_owned())
}

fn parse_variables(values : &Vec<JsonValue>) -> Result<Vec<VariableDeclaration>,String> {
    let mut var_decls = Vec::new();
    for value in values {
        if let Ok(var_decl) = parse_variable_declaration(value) {
            var_decls.push(var_decl);
        }
    }
    Ok(var_decls)
}

fn parse_structs(values : &Vec<JsonValue>) -> Result<Vec<StructDefinition>,String> {
    let mut struc_decls = Vec::new();
    for value in values {
        if let Ok(struc_decl) = parse_struct_definition(value) {
            struc_decls.push(struc_decl);
        }
    }
    Ok(struc_decls)
}


fn parse_variable_declaration(var_decl : &JsonValue) -> Result<VariableDeclaration,String> {
    let var_decl = parse_node(var_decl, "VariableDeclaration")?;
    let mut type_string = var_decl.get("typeDescriptions").unwrap().as_object().unwrap().get("typeString").unwrap().as_str().unwrap();

    Ok(VariableDeclaration {
        storage_location : var_decl.get("storageLocation").unwrap().as_str().unwrap().to_string(),
        visibility: var_decl.get("visibility").unwrap().as_str().unwrap().to_string(),
        name: var_decl.get("name").unwrap().as_str().unwrap().to_string(),
        typ: type_string.to_string().replace("struct ERC721Evol.", "").replace("struct ERC721EvolSpec.", ""), // *** fix parse structs corretamente
    })
}


fn parse_struct_definition(struc_decl : &JsonValue) -> Result<StructDefinition, String> {
    let str_decl = parse_node(struc_decl, "StructDefinition")?;
    let mut members_parsed = Vec::new();
    let members = struc_decl.get("members").unwrap().as_array().unwrap();
    for member in members {
        if let Ok(var_decl) = parse_variable_declaration(member) {
            members_parsed.push(var_decl);
        } else {
            return Err("Unable to parse in members".to_owned());
        }
    }

    Ok(StructDefinition {
        visibility: struc_decl.get("visibility").unwrap().as_str().unwrap().to_string(),
        name: struc_decl.get("name").unwrap().as_str().unwrap().to_string(),
        members: members_parsed,
    })
}


fn parse_events(values : &Vec<JsonValue>) -> Result<Vec<EventDefinition>,String> {
    let mut struc_decls = Vec::new();
    for value in values {
        if let Ok(struc_decl) = parse_event_definition(value) {
            struc_decls.push(struc_decl);
        }
    }
    Ok(struc_decls)
}

fn parse_event_definition(event_decl : &JsonValue) -> Result<EventDefinition, String> {
    let str_decl = parse_node(event_decl, "EventDefinition")?;
    let mut params_parsed = Vec::new();
    let members = event_decl.get("parameters").unwrap().as_object().unwrap().get("parameters")
    .unwrap().as_array().unwrap();

    for member in members {
        if let Ok(var_decl) = parse_variable_declaration(member) {
            params_parsed.push(var_decl);
        } else {
            return Err("Unable to parse in members".to_owned());
        }
    }

    Ok(EventDefinition {
        name: event_decl.get("name").unwrap().as_str().unwrap().to_string(),
        parameters: params_parsed,
    })
}



fn parse_function_specifications(values : &Vec<JsonValue>) -> Result<Vec<FunctionSpecification>,String> {
    let mut func_specs = Vec::new();
    for value in values {
        if let Ok(func_spec) = parse_function_specification(value) {
            func_specs.push(func_spec);
        }
    }
    Ok(func_specs)
}

fn parse_node<'a>(node_object : &'a JsonValue, typ : &str) -> Result<&'a Map<String, JsonValue>, String> {
    if let serde_json::Value::Object(map) = node_object {
        if let Some(serde_json::Value::String(s)) = map.get("nodeType") {
            if s == typ {
                return Ok(map);
            } else {
                return Err(format!("Expecting {} found {} ", typ, s));
            }
        }
    };
    Err(format!("Expecting {} node", typ))
}


fn parse_function_specification(func_decl: &JsonValue) -> Result<FunctionSpecification,String> {
    let func = parse_node(func_decl, "FunctionDefinition")?;
    let signature = parse_function_signature(func)?;
    let func_doc = func.get("documentation").unwrap().as_str().unwrap_or("").to_string();
    
    Ok(FunctionSpecification {
        spec: parse_function_postconditions(&func_doc).unwrap(),
        signature,
    })
}

fn parse_function_postconditions(string: &str) -> Result<String, String> {
    for line in string.lines() {
        let line_without_whitespace: String = line.split_whitespace().collect();
        if !&line_without_whitespace.starts_with("@noticepostcondition") && !&line_without_whitespace.starts_with("@noticeemits") {
            return Err("Function comment must contain @notice postcondition or @notice emits lines".to_owned());
        }
    }
    Ok(string.to_owned())
}

fn parse_function_signature(func_decl: &Map<String,JsonValue>) -> Result<FunctionSignature,String> {
    let mut ins = Vec::new();
    let in_pars = func_decl.get("parameters").unwrap().as_object().unwrap().get("parameters").unwrap().as_array().unwrap();
    for in_par in in_pars {
        if let Ok(var_decl) = parse_variable_declaration(in_par) {
            ins.push(var_decl);
        } else {
            return Err("Unable to parse in par".to_owned());
        }
    }

    let mut outs = Vec::new();
    let out_pars = func_decl.get("returnParameters").unwrap().as_object().unwrap().get("parameters").unwrap().as_array().unwrap();
    for out_par in out_pars {
        if let Ok(var_decl) = parse_variable_declaration(out_par) {
            outs.push(var_decl);
        } else {
            return Err("Unable to parse out par".to_owned());
        }
    }

    Ok(FunctionSignature {
        kind : func_decl.get("kind").unwrap().as_str().unwrap().to_string(), 
        name: func_decl.get("name").unwrap().as_str().unwrap().to_string(),
        ins,
        outs,
        visibility: func_decl.get("visibility").unwrap().as_str().unwrap().to_string(),
        state_mutability: func_decl.get("stateMutability").unwrap().as_str().unwrap().to_string(),
    })
}

pub fn parse_implementation(impl_path_ast : &Path, impl_path : &Path) -> Result<Implementation,String> {

    let file_name: Vec<&str> = impl_path_ast.file_name().unwrap().to_str().unwrap().split("_").collect();

    let file = File::open(Path::new(&impl_path_ast)).map_err( |_| {format!("The ast tree for the {} file could not be created.", file_name[0])})?;
    let reader = BufReader::new(file);

    let u : SolcArtifact = serde_json::from_reader(reader).map_err( |_| {format!("The parsing of the file {} could not be completed", file_name[0])})?;
    
    parse_pragma(&u.nodes[0])?;

    let imp = parse_impl_contract(&u.nodes, impl_path)?;

    Ok(imp)
}


fn parse_contracts_inherited(values : &Vec<JsonValue>) -> Result<Vec<Implementation>,String> {
    let mut contr_decls = Vec::new();
    for value in values {
        if value.get("nodeType").unwrap().as_str().unwrap().to_string() == "ImportDirective" {
            
           let absolute_path = value.get("absolutePath").unwrap().as_str().unwrap().to_string();

           let impl_json_path = format!("{}_json.ast", 
                Path::new(Path::new(&absolute_path).strip_prefix("/home/back/contracts/input").unwrap())
                    .file_name().unwrap().to_str().unwrap());

            let impl_sol_path = format!("{}", 
                    Path::new(Path::new(&absolute_path).strip_prefix("/home/back/contracts/input").unwrap())
                        .file_name().unwrap().to_str().unwrap());
                          
           let path = Path::new("contracts/input");

           if let Ok(var_decl) = parse_implementation(&path.join(&impl_json_path).as_path(), &path.join(&impl_sol_path).as_path()) {
                contr_decls.push(var_decl);
            }
        }
    }
    Ok(contr_decls)
}

fn parse_imports(values : &Vec<JsonValue>) -> Result<Vec<ImportDefinition>,String> {
    let mut import_decls = Vec::new();
    for value in values {
      
        if let Ok(impt_parsed) = parse_node(value, "ImportDirective") {
            let file = impt_parsed.get("file").unwrap().as_str().unwrap().to_string();
            import_decls.push( ImportDefinition{ file })
        }
    }
    
    Ok(import_decls)
}


fn parse_base_contracts(contract_elements : &Map<String, JsonValue>) -> Result<Vec<BaseContract>,String> {
    let mut import_decls = Vec::new();

    if let Some(serde_json::Value::Array(values)) = contract_elements.get("baseContracts") {
        
        for value in values {
            import_decls.push( BaseContract{ name: value.get("baseName").unwrap().get("name").unwrap().as_str().unwrap().to_string() })
        }
    }
    
    Ok(import_decls)
}


fn parse_impl_contract(contract_list : &Vec<JsonValue>,  impl_path : &Path) -> Result<Implementation, String> {

    let contract = &contract_list[contract_list.len() -1];

    let contract_elements = parse_node(&contract, "ContractDefinition")?;

    let src_info : Vec<&str> = contract.get("src").unwrap().as_str().unwrap().split(":").collect();

    if !contract_elements.get("documentation").unwrap().is_null() {
        return Err("Contract shouldn't have a comment".to_owned());
    };

    let contracts_inh = parse_contracts_inherited(&contract_list).unwrap();

    let (variables, functions, imports, base_contracts, structs, events) = if let Some(serde_json::Value::Array(values)) = contract_elements.get("nodes") {
        (parse_variables(&values)?,parse_function_implementations(&values, impl_path)?, parse_imports(&contract_list)?, 
        parse_base_contracts(&contract_elements)?, parse_structs(&values)?, parse_events(&values)?)
    } else {
        return Err("Missing definitions".to_owned());
    };
    
    Ok(Implementation {
        imports,
        base_contracts,
        structs,
        events,
        contract_name: contract.get("name").unwrap().as_str().unwrap().to_string(),
        variables,
        functions,
        contracts_inherited : contracts_inh,
        contract_definition: Src {
            offset: src_info[0].parse().unwrap(),
            length: src_info[1].parse().unwrap(),
            source_unit: src_info[2].parse().unwrap(),
        },
    })
}

fn parse_function_implementations(values : &Vec<JsonValue>, impl_path : &Path) -> Result<Vec<FunctionImplementation>,String> {
    let mut func_specs = Vec::new();
    for value in values {
        if let Ok(func_spec) = parse_function_implementation(value, impl_path) {
            func_specs.push(func_spec);
        }
    }
    Ok(func_specs)
}

fn parse_function_body(func: &Map<String,JsonValue>) { 

    let src_info_body_statements : &Vec<JsonValue> = func.get("body").unwrap().as_object().unwrap().get("statements")
                                                    .unwrap().as_array().unwrap();
    
    let mut func_body : Vec<Src> = Vec::new();                                                    
    for value in src_info_body_statements {
        
        let t : Vec<&str> = value.as_object().unwrap().get("src").unwrap().as_str().unwrap().split(":").collect();
        
        let s : Src = Src{ offset: t[0].parse().unwrap(),
            length: t[1].parse().unwrap(),
            source_unit: t[2].parse().unwrap(), };
            
            func_body.push(s);
    }
}

fn parse_function_implementation(func_decl: &JsonValue, impl_path : &Path) -> Result<FunctionImplementation,String> {
    let func = parse_node(func_decl, "FunctionDefinition")?;
    let signature = parse_function_signature(func)?;
    if !func.get("documentation").unwrap().is_null() {
        return Err("Function shouldn't have comment".to_owned())
    }

    let src_info : Vec<&str> = func.get("src").unwrap().as_str().unwrap().split(":").collect();

    let src_function_body : Vec<&str> = func.get("body").unwrap().as_object().unwrap().get("src")
                                    .unwrap().as_str().unwrap().split(":").collect();

    let src = Src {
        offset: src_function_body[0].parse().unwrap(),
        length: src_function_body[1].parse().unwrap(),
        source_unit: src_function_body[2].parse().unwrap(),
    };

    let mut impl_file = File::open(impl_path).map_err( |_| {"Error opening impl".to_owned()}).unwrap();

    let offset: u64 = src.offset; 
    let length: u64 = src.length;

    impl_file.seek(SeekFrom::Start(offset)).unwrap();

    let num_bytes_to_read = (length) as usize;

    let mut buffer = vec![0; num_bytes_to_read];
    impl_file.read_exact(&mut buffer).unwrap();

    let mut body_function = String::from_utf8(buffer).unwrap();


    // let mut body_function = "{
    //     return allowed[_owner][_spender];
    // }".to_owned();

    
    Ok(FunctionImplementation{
        signature,
        src, 
        body: Src {
            offset: src_function_body[0].parse().unwrap(),
            length: src_function_body[1].parse().unwrap(),
            source_unit: src_function_body[2].parse().unwrap(),
        },
        body_function
    })

}

