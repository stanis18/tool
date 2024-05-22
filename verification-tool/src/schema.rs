// @generated automatically by Diesel CLI.

diesel::table! {
    implementations (id) {
        id -> Int4,
        content -> Text,
        name -> Text,
        verify -> Bool,
        id_log -> Int4,
    }
}

diesel::table! {
    logs (id) {
        id -> Int4,
        author_address -> Text,
        specification_id -> Text,
        specification -> Text,
        specification_file_name -> Text,
        proxy_address -> Text,
        proxy -> Text,
        chain_id -> Text,
        created_at -> Timestamp,
        deployed -> Bool,
    }
}

diesel::table! {
    relations (id) {
        id -> Int4,
        relation -> Text,
        id_log -> Int4,
    }
}

diesel::allow_tables_to_appear_in_same_query!(
    implementations,
    logs,
    relations,
);
