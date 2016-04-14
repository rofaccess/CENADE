# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160413145411) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  limit: 50, default: "", null: false
    t.string   "username",               limit: 30, default: "", null: false
    t.string   "encrypted_password",                default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                     default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.integer  "failed_attempts",                   default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree
  add_index "admins", ["unlock_token"], name: "index_admins_on_unlock_token", unique: true, using: :btree

  create_table "areas", force: :cascade do |t|
    t.string   "nombre",     null: false
    t.integer  "costo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "configuraciones", force: :cascade do |t|
    t.string   "empresa_nombre",           limit: 50,  default: ""
    t.string   "empresa_direccion",        limit: 125, default: ""
    t.string   "empresa_tel",              limit: 50,  default: ""
    t.string   "empresa_email",            limit: 50,  default: ""
    t.string   "empresa_horario_atencion", limit: 100, default: ""
    t.string   "empresa_web",              limit: 40,  default: ""
    t.string   "empresa_logo"
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
  end

  create_table "empleados", force: :cascade do |t|
    t.integer  "persona_id",                               null: false
    t.integer  "especialidad_id"
    t.string   "type",            limit: 15,  default: "", null: false
    t.string   "cargo",           limit: 100, default: "", null: false
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "empleados", ["deleted_at"], name: "index_empleados_on_deleted_at", unique: true, using: :btree

  create_table "encargados", force: :cascade do |t|
    t.string   "padre_nombre",           limit: 60,  default: ""
    t.string   "padre_edad",             limit: 3,   default: ""
    t.string   "padre_prof_act_ant",     limit: 100, default: ""
    t.string   "madre_nombre",           limit: 60,  default: ""
    t.string   "madre_edad",             limit: 3,   default: ""
    t.string   "madre_prof_act_ant",     limit: 100, default: ""
    t.string   "encargado_nombre",       limit: 60,  default: ""
    t.string   "encargado_edad",         limit: 3,   default: ""
    t.string   "encargado_prof_act_ant", limit: 100, default: ""
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  create_table "especialidades", force: :cascade do |t|
    t.string   "descripcion", limit: 50, default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "especialidades", ["descripcion"], name: "index_especialidades_on_descripcion", unique: true, using: :btree

  create_table "estados_civiles", force: :cascade do |t|
    t.string   "descripcion", limit: 15, default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "estados_civiles", ["descripcion"], name: "index_estados_civiles_on_descripcion", unique: true, using: :btree

  create_table "fechas", force: :cascade do |t|
    t.integer  "horario_id",               null: false
    t.date     "fecha",                    null: false
    t.time     "turno_manana_hora_inicio"
    t.time     "turno_manana_hora_fin"
    t.time     "turno_tarde_hora_inicio"
    t.time     "turno_tarde_hora_fin"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "horarios", force: :cascade do |t|
    t.integer  "empleado_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pacientes", force: :cascade do |t|
    t.integer  "persona_id",                                null: false
    t.integer  "encargado_id"
    t.date     "fecha_ingreso",                             null: false
    t.boolean  "es_menor"
    t.string   "lugar_nacimiento", limit: 100, default: ""
    t.string   "profesion",        limit: 50,  default: ""
    t.string   "lugar_trabajo",    limit: 100, default: ""
    t.datetime "deleted_at"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  create_table "permissions", force: :cascade do |t|
    t.string   "grupo"
    t.string   "model"
    t.string   "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "permissions_roles", force: :cascade do |t|
    t.integer  "role_id"
    t.integer  "permission_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "personas", force: :cascade do |t|
    t.string   "ci",               limit: 15,  default: "", null: false
    t.string   "nombre",           limit: 30,  default: "", null: false
    t.string   "apellido",         limit: 30,  default: "", null: false
    t.string   "direccion",        limit: 125, default: ""
    t.string   "telefono",         limit: 50,  default: ""
    t.string   "email",            limit: 50,  default: ""
    t.string   "ruc",              limit: 20,  default: ""
    t.datetime "fecha_nacimiento"
    t.string   "sexo",             limit: 9,   default: ""
    t.string   "edad",             limit: 3,   default: ""
    t.string   "nacionalidad",     limit: 20,  default: "", null: false
    t.integer  "estado_civil_id"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "personas", ["deleted_at"], name: "index_personas_on_deleted_at", unique: true, using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "turnos", force: :cascade do |t|
    t.integer  "paciente_id",      null: false
    t.datetime "fecha_expedicion", null: false
    t.date     "fecha_consulta",   null: false
    t.integer  "area_id",          null: false
    t.integer  "doctor_id",        null: false
    t.string   "estado",           null: false
    t.integer  "monto"
    t.boolean  "paga",             null: false
    t.string   "nro_factura"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "username",               limit: 30, default: "", null: false
    t.string   "encrypted_password",                default: "", null: false
    t.string   "rol",                    limit: 15, default: "", null: false
    t.string   "profile_foto"
    t.integer  "empleado_id",                                    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                     default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.integer  "failed_attempts",                   default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

  add_foreign_key "empleados", "especialidades", on_delete: :restrict
  add_foreign_key "empleados", "personas", on_delete: :restrict
  add_foreign_key "fechas", "horarios", on_delete: :restrict
  add_foreign_key "horarios", "empleados", on_delete: :cascade
  add_foreign_key "pacientes", "personas", column: "encargado_id", on_delete: :restrict
  add_foreign_key "pacientes", "personas", on_delete: :restrict
  add_foreign_key "permissions_roles", "permissions"
  add_foreign_key "permissions_roles", "roles"
  add_foreign_key "personas", "estados_civiles", on_delete: :restrict
  add_foreign_key "turnos", "areas", on_delete: :restrict
  add_foreign_key "turnos", "empleados", column: "doctor_id", on_delete: :restrict
  add_foreign_key "turnos", "pacientes", on_delete: :restrict
  add_foreign_key "users", "empleados", on_delete: :restrict
end
