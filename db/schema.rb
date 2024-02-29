ActiveRecord::Schema[7.1].define(version: 2024_02_08_204631) do
  create_table "accesses", force: :cascade do |t|
    t.string "ip_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "link_id", null: false
    t.index ["link_id"], name: "index_accesses_on_link_id"
  end

  create_table "links", force: :cascade do |t|
    t.string "slug"
    t.string "name"
    t.string "url"
    t.string "url_short"
    t.string "link_type"
    t.integer "user_id"
    t.string "password" # link privado
    t.datetime "expiration_date" # link temporal
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "used" # link efimero
    t.boolean "access_attempted" # link privado
    t.index ["slug"], name: "index_links_on_slug", unique: true
    t.index ["user_id"], name: "index_links_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "username"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  #Las claves foráneas son restricciones que aseguran la integridad referencial entre dos tablas en una base de datos relacional.
  add_foreign_key "accesses", "links"
  add_foreign_key "links", "users"
end
