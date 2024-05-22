use std::{path::Path};
use std::fs;


use crate::{checker::{check_synctatic_conformance, generate_merge_contract,generate_refinement_contract, generate_old_contract}, 
            parser::{parse_implementation, parse_specification, Implementation, Specification}, 
            // proxy::{config_proxy}, 
            util::{write_file, generate_ast_contract, verify_contract, generate_compiled_contract, parse_merge_files, search_merge_files_dir}, 
            db::{select_on_table, select_implementations},
            models::{ImplementationFile} };


pub async fn verify_deploy_contract(impl_path_input: &Path, spec_path_input: &Path, imp: &Implementation, 
    spec: &Specification) -> Result<(), String> {

    //copying the implementation file    
    let impl_path_output = Path::new("contracts/input").join(&impl_path_input.file_name().unwrap().to_str().unwrap());

    //copying the specification file        
    let spec_path_output = Path::new("contracts/input").join(&spec_path_input.file_name().unwrap().to_str().unwrap());    
        
   check_synctatic_conformance(&spec, &imp, false)?;    
   
    // generating merged contract
    generate_merge_contract(&spec, &imp, true)?;

    let list_verification = search_merge_files_dir(Path::new("contracts/input"));
    parse_merge_files(list_verification.unwrap())?;

    generate_compiled_contract(&impl_path_output.file_name().unwrap().to_str().unwrap())?;
       
    Ok(())
}


pub fn get_specification(spec_url: &Path) -> Result<Specification, String>{

    let spec_path_output = Path::new("contracts/input").join(&spec_url.file_name().unwrap().to_str().unwrap());    

    generate_ast_contract(spec_path_output.file_name().unwrap().to_str().unwrap());

    let inp_path = Path::new("contracts/input");
    let spec_json_path = format!("{}_json.ast", Path::new(&spec_path_output).file_name().unwrap().to_str().unwrap());
    let spec = parse_specification(&inp_path.join(&spec_json_path).as_path())?;
    Ok(spec)
}

pub fn get_implementation(impl_url: &Path) -> Result<Implementation, String>{

    let impl_path_output = Path::new("contracts/input").join(&impl_url.file_name().unwrap().to_str().unwrap());

    generate_ast_contract(impl_path_output.file_name().unwrap().to_str().unwrap());

    let imp_path = Path::new("contracts/input");
    let impl_json_path = format!("{}_json.ast", Path::new(&impl_path_output).file_name().unwrap().to_str().unwrap());
    
    let imp = parse_implementation(&imp_path.join(&impl_json_path).as_path(), &impl_path_output)?;

    Ok(imp)
}


pub fn filter_file_implementation(list_implementation: &Vec<ImplementationFile>) -> Result<String, String> {

    let filtered_variable:Vec<_> = list_implementation.iter()
                                .filter(|variable| variable.verify).collect();

    Ok (filtered_variable[0].name.clone())                            
}




pub async fn upgrade_contract(impl_path_input: &Path, imp: &Implementation, spec_new: &mut Specification, proxy_address: &String, author_account: &String, chain_id:&String, relations: &Vec<String>) -> Result<(), String> {

    //copying registry
    // if let Err(_) = fs::copy("contracts/registry.sol", "contracts/input/registry.sol") {
    //     return Err("Error for generating the registry contract".to_owned());
    // };
    
    let imp_path = Path::new("contracts/input");

    let log = select_on_table(&proxy_address, &author_account, &chain_id).unwrap();

    if log.len() == 0 {
        return Err(format!("Could not find a specification for this id {}", &proxy_address));
    }

    write_file(&log[0].specification, &log[0].specification_file_name );

    let implementation_files_old = select_implementations(&log[0].id).unwrap();

    for imp_file in &implementation_files_old {
        write_file(&imp_file.content, &imp_file.name);
    }
    
    
    // write_file(&log[0].proxy, &"implementedproxy.sol".to_string() );
    
    let mut spec_old = get_specification(imp_path.join(&log[0].specification_file_name).as_path()).expect("Expected specification");
    
    let imp_file_name = filter_file_implementation(&implementation_files_old).unwrap();
    let imp_old = get_implementation(imp_path.join(&imp_file_name).as_path()).unwrap();
    
    check_synctatic_conformance(&spec_new, &imp, true)?;

    generate_merge_contract(&spec_new, &imp, true)?;
    
    generate_old_contract(&imp_old, &mut spec_old, spec_new, &relations);

    generate_refinement_contract(&spec_old, spec_new, &relations)?;

    let refinement_contract_file = format!("{}.sol", "Refinement_Contract");

    let verified_refinement_contract = verify_contract(refinement_contract_file)?;

    // println!("---------");
    // println!("{:?}", verified_refinement_contract);
    // println!("*********");
 
    // generate_compiled_contract(&impl_path_input.file_name().unwrap().to_str().unwrap())?;
    

    // generate_compiled_contract(&"implementedproxy.sol")?;

    Ok(())
}





// pub async fn get_merge_contract(impl_path_input: &Path, spec_path_input: &Path, imp: &Implementation, 
//     spec: &Specification) -> Result<(), String> {

//     //copying the implementation file    
//     let impl_path_output = Path::new("contracts/input").join(&impl_path_input.file_name().unwrap().to_str().unwrap());

//     //copying the specification file        
//     let spec_path_output = Path::new("contracts/input").join(&spec_path_input.file_name().unwrap().to_str().unwrap());    
   
//     // generating merged contract
//     generate_merge_contract(&spec, &imp, true)?;



       
//     Ok(())
// }