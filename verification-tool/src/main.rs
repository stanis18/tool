#[macro_use] extern crate rocket;

use crate::{db::{select_specifications, select_on_table, insert_on_table, select_relations}};
use crate::{proxy::{config_facet, generate_facet}};
use crate::{checker::{generate_merge_contract}};
use crate::{models::{Relations, Logs, NewLogs, File, FileMerge}};
use crate::{util::{write_file,get_number_argument_constructor,AssignedVariable, get_compiled_files, delete_dir_contents}};
use crate::{old_main_j::{verify_deploy_contract, upgrade_contract, get_specification, get_implementation}};
mod schema;
mod models;
mod db;
mod util;
mod parser;
mod checker;
mod proxy;
mod old_main_j;
use rocket::serde::{Serialize, Deserialize, json::Json};
use rocket::http::Header;
use rocket::fairing::{Fairing, Info, Kind};
use rocket::{http::Method, http::Status, Request, Response};
use rocket::response::status::BadRequest;
use std::{path::Path};
use diesel::pg::PgConnection;
use regex::Regex;



#[get("/teste")]
fn teste()  {


    let t1 = "transferFrom(global_variable, to, tokenId);";
    let t2 = "require(_checkOnERC721Received(global_variable, to, tokenId, _data));";
    let t3 = "address owner = global_variable[tokenId];";
    let t4 = "return owner != global_variable;";
    let t5 = "_tokenOwner[global_variable] = to;";
    let t6 = "return ( global_variable == owner || getApproved(tokenId) == global_variable || isApprovedForAll(owner, global_variable));";


    let text = [t1, t2, t3, t4, t5, t6].join(" ");


    let target_word = "global_variable";
    let replacement_word = "this.getStorage().global_variable";
    let pattern = format!(r"\b{}\b", regex::escape(target_word));

    
    let re = Regex::new(&pattern).expect("Invalid regex pattern");
    let replaced_text = re.replace_all(&text, replacement_word);

    println!("Original Text: {}", text);
    println!("Replaced Text: {}", replaced_text);



    // let pattern = format!(r"\b{}\b", regex::escape("global_variable"));
    // let re = Regex::new(&pattern).expect("Invalid regex pattern");
    
    // let word_found = re.is_match(result);


    // if word_found {
    //     println!("The word '{}' was found in the text.", target_word);
    // } else {
    //     println!("The word '{}' was not found in the text.", target_word);
    // }

    // while()




    // let re = Regex::new(r"\s*forall\s+(?<variable01>\w+)\[(?<param01>\w+)\]\.?(?<complement01>\w+)?\s*\==\s*(?<variable02>\w+)\[(?<param02>\w+)\]\.?(?<complement02>\w+)?\s*").unwrap();

    // println!("forall 01: {:?}", re.is_match("forall x[xvirus] == t[tvirus].value"));
    // println!("forall 02: {:?}", re.is_match("forall t[tvirus].value == x[xvirus]"));
    // println!("forall 03: {:?}", re.is_match("forall t[tvirus]==x[xvirus]"));

    // let Some(caps) = re.captures("forall t[tvirus] == x[xvirus] ") else {
    //     println!("no match!");
    //     return;
    // };


    // println!("The variable01 is: {}", &caps["variable01"]);
    // println!("The param01 is: {}", &caps["param01"]);

    // let complement01 = &caps.name("complement01");
    // println!("The complement01 is: {:?}", complement01);
    
    
    // println!("The variable02 is: {}", &caps["variable02"]);
    // println!("The param02 is: {}", &caps["param02"]);

    // println!("The complement02 is: {:?}", &caps["complement02"]);

}




#[get("/listupgrades/<wallet_address>")]
fn list_upgrades(wallet_address: String) -> Result<Json<Vec<Logs>>, BadRequest<String>> {
    let logs = select_specifications(&wallet_address).unwrap();
    Ok(Json(logs))
}

#[get("/listrelations/<id_log>")]
fn list_relations(id_log: i32) -> Result<Json<Vec<Relations>>, BadRequest<String>> {
    let relations = select_relations(&id_log).unwrap();
    Ok(Json(relations))
}

#[post("/getconstructorarguments", format = "json", data = "<payload>")]
fn get_constructor_arguments(payload: Json<ContructorArguments>) -> Result<Json<Vec<AssignedVariable>>, BadRequest<String>> {
    
    for file in &payload.implementation_files {
        write_file(&file.content, &file.name);
    }
    let impl_url = format!("contracts/input/{}", &payload.file_to_be_verified);
    let imp = get_implementation(Path::new(&impl_url));
    
    if let Err(error) = &imp {
       return Err(BadRequest(Some(error.to_string())));
    }

    let constructor_arguments = get_number_argument_constructor(&imp.unwrap()).unwrap();

    let mut parameters_and_values: Vec<AssignedVariable> = Vec::new();

    for i in 0..constructor_arguments.len() {
        let variable_value = AssignedVariable {
            variable_declaration: constructor_arguments[i].clone(),
            variable_value: "".to_owned(),
        };
        parameters_and_values.push(variable_value);
    }
    Ok(Json(parameters_and_values))
}


#[post("/getcontract", format = "json", data = "<payload>")]
async fn get_contract(payload: Json<DeployContract>) -> Result<Json<Vec<ContractCompiled>>, BadRequest<String>> {

    write_file(&payload.specification_file.content, &payload.specification_file.name);

    for file in &payload.implementation_files {
        write_file(&file.content, &file.name);
    }

    let spec_url = format!("contracts/input/{}", &payload.specification_file.name);
    let spec = get_specification(Path::new(&spec_url)).unwrap();

    let impl_url = format!("contracts/input/{}", &payload.file_to_be_verified);
    let imp = get_implementation(Path::new(&impl_url)).unwrap();

    let result = verify_deploy_contract(Path::new(&impl_url), Path::new(&spec_url), &imp, &spec ).await;

    if let Err(error) = &result {
        return Err(BadRequest(Some(error.to_string())));
    }

    let path_contract_abi = Path::new("contracts/input").join(&format!("{}.abi", &imp.contract_name));
    let path_contract_bin = Path::new("contracts/input").join(&format!("{}.bin", &imp.contract_name));

    let contents_contract_abi = get_compiled_files(&path_contract_abi);
    let contents_contract_bin = get_compiled_files(&path_contract_bin);

    let contract =  ContractCompiled { category: "contract".to_string(), abi: contents_contract_abi.unwrap(), 
    bin: contents_contract_bin.unwrap(), file: "".to_string(), address: "".to_string() };
    
    let list: Vec<ContractCompiled> = vec![contract];

    // delete_dir_contents();

    Ok(Json(list))
}


#[post("/upgradecontract/<author_wallet>/<chain_id>", format = "json", data = "<payload>")]
async fn upgrade_contract_file(author_wallet:String, chain_id:String, payload:Json<UpgradeContract>) -> Result<Json<Vec<ContractCompiled>>, BadRequest<String>> {
    
    for file in &payload.implementation_files {
        write_file(&file.content, &file.name);
    }

    write_file(&payload.specification_file.content, &payload.specification_file.name);

    let spec_url = format!("contracts/input/{}", &payload.specification_file.name);
    let mut spec_new = get_specification(Path::new(&spec_url)).unwrap();

    let impl_url = format!("contracts/input/{}", &payload.file_to_be_verified);
    let imp = get_implementation(Path::new(&impl_url)).unwrap();

    let impl_url = format!("contracts/input/{}", &payload.file_to_be_verified);
    
    let result = upgrade_contract(Path::new(&impl_url), &imp, &mut spec_new, &payload.proxy_address, &author_wallet, &chain_id, &payload.relations).await;

    if let Err(error) = &result {
        return Err(BadRequest(Some(error.to_string())));
    }

    let log = select_on_table(&payload.proxy_address, &author_wallet, &chain_id).unwrap();
   

    let list: Vec<ContractCompiled> = vec![]; 
    
   // delete_dir_contents();

   let new_log = NewLogs {
        author_address: author_wallet.clone(), 
        specification_id: payload.specification_id.clone(),
        specification: payload.specification_file.content.clone(),
        specification_file_name: payload.specification_file.name.clone(),
        proxy_address: payload.proxy_address.clone(), 
        proxy: "proxy".to_string().clone(),
        chain_id: chain_id.clone(),
        implementation_files: payload.implementation_files.clone(),
        relations: payload.relations.clone()
    };

    let result = insert_on_table(&new_log);
    Ok(Json(list))
}

#[post("/savelog", format = "json", data = "<payload>")]
fn save_log(payload: Json<NewLogs>) -> Result<(), BadRequest<String>> {
    
    let result = insert_on_table(&payload);

    if let Err(error) = &result {
        return Err(BadRequest(Some(error.to_string())));
    }
    
    Ok(())
}


#[post("/proxycontract", format = "json", data = "<payload>")]
async fn proxy_contract_file(payload:Json<UpgradeContract>) -> Result<(), BadRequest<String>> {
    
    for file in &payload.implementation_files {
        write_file(&file.content, &file.name);
    }

    write_file(&payload.specification_file.content, &payload.specification_file.name);

    let impl_url = format!("contracts/input/{}", &payload.file_to_be_verified);
    let imp = get_implementation(Path::new(&impl_url)).unwrap();

    // println!("{:?}", &imp);

    generate_facet(&imp);

    Ok(())
}



#[post("/getmergecontract", format = "json", data = "<payload>")]
async fn get_merge_contract(payload: Json<MergeContract>) -> Result<Json<Vec<FileMerge>>, BadRequest<String>> {

    write_file(&payload.specification_file.content, &payload.specification_file.name);

    for file in &payload.implementation_files {
        write_file(&file.content, &file.name);
    }

    let spec_url = format!("contracts/input/{}", &payload.specification_file.name);
    let spec = get_specification(Path::new(&spec_url)).unwrap();

    let impl_url = format!("contracts/input/{}", &payload.file_to_be_verified);
    let imp = get_implementation(Path::new(&impl_url)).unwrap();

    let result = generate_merge_contract(&spec, &imp, true);

    if let Err(error) = &result {
        return Err(BadRequest(Some(error.to_string())).to_owned() );
    }

    let mut files_merge = Vec::new();

    for file in &payload.implementation_files {

        let file_path = format!("contracts/input/{}", &file.name);

       let file_merge =  get_compiled_files(Path::new(&file_path)).unwrap();

       let f =  FileMerge {
        name: file.name.to_owned(), 
        content: file_merge
       };

       files_merge.push(f);
    } 
    
    delete_dir_contents();

    Ok(Json(files_merge))
}




#[launch]
fn rocket() -> _ {
    rocket::build()
    .attach(CORS)
    .mount("/", routes![list_upgrades])
    .mount("/", routes![get_constructor_arguments])
    .mount("/", routes![upgrade_contract_file])
    .mount("/", routes![get_contract])
    .mount("/", routes![save_log])
    .mount("/", routes![list_relations])
    .mount("/", routes![teste])
    .mount("/", routes![proxy_contract_file])
    .mount("/", routes![get_merge_contract])
}


#[derive(Serialize,Deserialize, Debug)]
pub struct ContractCompiled {
    pub category: String,
    pub abi: String, 
    pub bin: String, 
    pub file: String,
    pub address: String, 
}

#[derive(Serialize,Deserialize, Debug)]
pub struct DeployContract {
    pub specification_file: File,
    pub file_to_be_verified: String, 
    pub implementation_files: Vec<File>, 
    pub specification_id: String,
    pub constructor_arguments: Vec<AssignedVariable>,
}

#[derive(Serialize,Deserialize, Debug)]
pub struct MergeContract {
    pub specification_file: FileMerge,
    pub file_to_be_verified: String, 
    pub implementation_files: Vec<FileMerge>, 
}

#[derive(Serialize,Deserialize, Debug)]
pub struct UpgradeContract {
    pub specification_file: File,
    pub specification_id: String,
    pub implementation_files: Vec<File>, 
    pub proxy_address: String,
    pub file_to_be_verified: String,
    pub relations: Vec<String>, 
}

#[derive(Serialize,Deserialize, Debug)]
pub struct ContructorArguments {
    pub implementation_files: Vec<File>, 
    pub file_to_be_verified: String
}




pub struct CORS;

#[rocket::async_trait]
impl Fairing for CORS {
    fn info(&self) -> Info {
        Info {
            name: "Cross-Origin-Resource-Sharing Middleware",
            kind: Kind::Response,
        }
    }

    async fn on_response<'r>(&self,request: &'r Request<'_>,response: &mut Response<'r>) {
        response.set_header(Header::new("Access-Control-Allow-Origin", "*"));
        response.set_header(Header::new("Access-Control-Allow-Credentials", "true"));
        response.set_header(Header::new("Access-Control-Allow-Methods", "GET,HEAD,OPTIONS,POST,PUT"));
        response.set_header(Header::new("Access-Control-Allow-Headers", "Access-Control-Allow-Headers, Origin,Accept, X-Requested-With, Content-Type, Access-Control-Request-Method, Access-Control-Request-Headers"));    

        if response.status() == Status::NotFound && request.method() == Method::Options {
            response.set_status(Status::NoContent);
        }
    }
}


