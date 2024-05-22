use diesel::pg::PgConnection;
use diesel::prelude::*;
use dotenv::dotenv;
use diesel::insert_into;
use std::env;
use rocket::serde::{Serialize, Deserialize};
use crate::schema::{relations, logs, implementations};
use crate::models::{Relations, Logs, NewLogs, ImplementationFile};


pub fn establish_connection_pg() -> PgConnection {
    dotenv().ok();

    let database_url = env::var("DATABASE_URL").expect("DATABASE_URL must be set");
    PgConnection::establish(&database_url)
        .unwrap_or_else(|_| panic!("Error connecting to {}", &database_url))
}


pub fn insert_on_table(new_log: &NewLogs) -> Result<(), String> {

    let connection = &mut establish_connection_pg();

    let transaction_log = insert_into(logs::dsl::logs)
    .values((logs::author_address.eq(&new_log.author_address), logs::specification.eq(&new_log.specification), 
    logs::specification_id.eq(&new_log.specification_id), logs::proxy_address.eq(&new_log.proxy_address), 
    logs::specification_file_name.eq(&new_log.specification_file_name), logs::proxy.eq(&new_log.proxy), 
    logs::chain_id.eq(&new_log.chain_id)))
    .execute(connection);

    let results = logs::dsl::logs
    .order(logs::created_at.desc())
    .limit(1)
    .load::<Logs>(connection)
    .expect("Error loading logs");

    let id:i32 = results[0].id;

    for i in 0..new_log.implementation_files.len() {

       let transaction_implementations =  insert_into(implementations::dsl::implementations)
        .values((implementations::content.eq(&new_log.implementation_files[i].content), 
                 implementations::name.eq(&new_log.implementation_files[i].name),
                 implementations::id_log.eq(&id), 
                 implementations::verify.eq(&new_log.implementation_files[i].verify)))
        .execute(connection);
    }

    for i in 0..new_log.relations.len() {

       let transaction_relations = insert_into(relations::dsl::relations)
        .values((relations::relation.eq(&new_log.relations[i]), 
                 relations::id_log.eq(&id)))
        .execute(connection);
    }   

    Ok(())
}


pub fn select_on_table(proxy_address:&String, author_address:&String, chain_id:&String) -> Result<Vec<Logs>, String> {

    let connection = &mut establish_connection_pg();

    let results = logs::dsl::logs
        .filter(logs::proxy_address.ilike(&proxy_address))
        .filter(logs::author_address.ilike(&author_address))
        .filter(logs::chain_id.ilike(&chain_id))
        .order(logs::created_at.desc())
        .limit(1)
        .load::<Logs>(connection)
        .expect("Error loading logs");
        Ok(results)
}

pub fn select_specifications(author_address: &String) -> Result<Vec<Logs>, String> {

    let connection = &mut establish_connection_pg();

    let results = logs::dsl::logs
        .filter(logs::author_address.ilike(&author_address))
        .load::<Logs>(connection)
        .expect("Error loading logs");
        Ok(results)
}


pub fn select_relations(id_log:&i32) -> Result<Vec<Relations>, String> {

    let connection = &mut establish_connection_pg();

    let results = relations::dsl::relations
        .filter(relations::id_log.eq(&id_log))
        .load::<Relations>(connection)
        .expect("Error loading relations");
        Ok(results)
}

pub fn select_implementations(id_log:&i32) -> Result<Vec<ImplementationFile>, String> { 

    let connection = &mut establish_connection_pg();

    let results = implementations::dsl::implementations
        .filter(implementations::id_log.eq(&id_log))
        .load::<ImplementationFile>(connection)
        .expect("Error loading implementations");
        Ok(results)
}