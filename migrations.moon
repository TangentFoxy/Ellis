import create_table, types from require "lapis.db.schema"

{
  [1582729121]: =>
    create_table "users", {
      { "id", types.serial primary_key: true }
      { "name", types.varchar unique: true }
      { "email", types.varchar null: true }
      { "digest", types.varchar }
    }
    create_table "items", {
      { "id", types.serial primary_key: true }
      { "user_id", types.foreign_key }
      { "text", types.text }
      { "score", types.integer default: 0 }
      { "time", types.double }
      { "sort", types.double }
      { "done", types.boolean default: false }
    }
    create_table "tags", {
      { "id", types.serial primary_key: true }
      { "user_id", types.foreign_key }
      { "match", types.varchar }
      { "score", types.integer default: 0 }
      { "time", types.double }
      { "sort", types.double }
      { "visible", types.boolean default: true }
      { "parent_id", types.foreign_key null: true }
    }
    create_table "item_tags", {
      { "id", types.serial primary_key: true }
      { "tag_id", types.foreign_key }
      { "item_id", types.foreign_key }
    }
    create_table "orphan_items", {
      { "id", types.serial primary_key: true }
      { "item_id", types.foreign_key }
    }
}
