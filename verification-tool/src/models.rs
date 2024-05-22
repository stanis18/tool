use diesel::prelude::*;
use std::time::SystemTime;
use rocket::serde::{Serialize, Deserialize};
use crate::schema::{relations, logs, implementations};


#[derive(Queryable, Insertable, Serialize, Deserialize,Debug)]
#[diesel(table_name = relations)]
pub struct Relations {
    pub id: i32,
    pub relation: String, 
    pub id_log: i32, 
}


#[derive(Queryable, Insertable, Serialize, Deserialize, Debug, Identifiable)]
#[diesel(table_name = logs)]
pub struct Logs {
    pub id: i32,
    pub author_address: String, 
    pub specification_id: String,
    pub specification: String,
    pub specification_file_name: String,
    pub proxy_address: String, 
    pub proxy: String,
    pub chain_id: String,
    pub created_at : SystemTime,
    pub deployed: bool,
}


#[derive(Queryable, Insertable, Serialize, Deserialize,Debug)]
#[diesel(table_name = implementations)]
pub struct ImplementationFile {
    pub id: i32,
    pub content: String, 
    pub name: String,
    pub verify:bool, 
    pub id_log: i32, 
}


#[derive(Serialize,Deserialize, Debug,Clone)]
pub struct File {
    pub name: String, 
    pub content: String,
    pub verify:bool,
}

#[derive(Serialize,Deserialize, Debug,Clone)]
pub struct FileMerge {
    pub name: String, 
    pub content: String,
}


#[derive(Serialize,Deserialize,Debug,Clone)]
pub struct NewLogs {
    pub author_address: String, 
    pub specification_id: String,
    pub specification: String,
    pub specification_file_name: String,
    pub proxy_address: String, 
    pub proxy: String,
    pub chain_id: String,
    pub implementation_files: Vec<File>,
    pub relations: Vec<String>,
}

