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

ActiveRecord::Schema.define(version: 20160505065702) do

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
    t.string   "nombre",       limit: 50, default: "",  null: false
    t.decimal  "costo_usual",             default: 0.0
    t.decimal  "costo_casual",            default: 0.0
    t.string   "costo",        limit: 7,  default: ""
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  add_index "areas", ["nombre"], name: "index_areas_on_nombre", unique: true, using: :btree

  create_table "configuraciones", force: :cascade do |t|
    t.string   "empresa_nombre",     limit: 50,  default: ""
    t.string   "empresa_direccion",  limit: 125, default: ""
    t.string   "empresa_tel",        limit: 50,  default: ""
    t.string   "empresa_email",      limit: 50,  default: ""
    t.string   "empresa_web",        limit: 40,  default: ""
    t.string   "empresa_logo"
    t.string   "hora_inicio_mañana"
    t.string   "hora_fin_mañana"
    t.string   "hora_inicio_tarde"
    t.string   "hora_fin_tarde"
    t.string   "dias_atencion"
    t.integer  "usuario_admin"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "consultas", force: :cascade do |t|
    t.integer  "profesional_salud_id"
    t.integer  "paciente_id",                                   null: false
    t.integer  "area_id",                                       null: false
    t.date     "fecha"
    t.string   "profesional_salud",    limit: 60,  default: ""
    t.string   "motivo_consulta",      limit: 300, default: ""
    t.string   "evaluacion",           limit: 300, default: ""
    t.string   "tratamiento",          limit: 600, default: ""
    t.string   "observaciones",        limit: 250, default: ""
    t.datetime "deleted_at"
  end

  add_index "consultas", ["area_id"], name: "index_consultas_on_area_id", using: :btree
  add_index "consultas", ["paciente_id"], name: "index_consultas_on_paciente_id", using: :btree
  add_index "consultas", ["profesional_salud_id"], name: "index_consultas_on_profesional_salud_id", using: :btree

  create_table "custom_auto_increments", force: :cascade do |t|
    t.string   "counter_model_name"
    t.integer  "counter",            default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "custom_auto_increments", ["counter_model_name"], name: "index_custom_auto_increments_on_counter_model_name", using: :btree

  create_table "empleados", force: :cascade do |t|
    t.integer  "persona_id",                             null: false
    t.integer  "area_id"
    t.string   "type",          limit: 15,  default: "", null: false
    t.string   "cargo",         limit: 100, default: "", null: false
    t.string   "abr_profesion", limit: 5,   default: ""
    t.string   "costo",         limit: 7,   default: ""
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "empleados", ["area_id"], name: "index_empleados_on_area_id", using: :btree
  add_index "empleados", ["deleted_at"], name: "index_empleados_on_deleted_at", unique: true, using: :btree
  add_index "empleados", ["persona_id"], name: "index_empleados_on_persona_id", using: :btree

  create_table "encargados", force: :cascade do |t|
    t.string   "padre_nombre",           limit: 60,  default: ""
    t.string   "padre_edad",             limit: 3,   default: ""
    t.string   "padre_prof_act_ant",     limit: 100, default: ""
    t.string   "madre_nombre",           limit: 60,  default: ""
    t.string   "madre_edad",             limit: 3,   default: ""
    t.string   "madre_num_hijos",        limit: 2,   default: ""
    t.string   "madre_prof_act_ant",     limit: 100, default: ""
    t.string   "encargado_nombre",       limit: 60,  default: ""
    t.string   "encargado_edad",         limit: 3,   default: ""
    t.string   "encargado_prof_act_ant", limit: 100, default: ""
    t.integer  "paciente_id"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.datetime "deleted_at"
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

  add_index "fechas", ["horario_id"], name: "index_fechas_on_horario_id", using: :btree

  create_table "ficha_fisioterapia_ninos", force: :cascade do |t|
    t.integer  "area_id",                                          null: false
    t.integer  "doctor_id",                                        null: false
    t.integer  "paciente_id",                                      null: false
    t.string   "control_embarazo",        limit: 100, default: ""
    t.string   "edad_gestacional",        limit: 100, default: ""
    t.string   "tipo_parto",              limit: 100, default: ""
    t.string   "peso_nacer",              limit: 50,  default: ""
    t.string   "apgar",                   limit: 50,  default: ""
    t.string   "antecedentes_familiares", limit: 250, default: ""
    t.string   "condicion_general",       limit: 500, default: ""
    t.date     "fecha",                                            null: false
    t.integer  "nro_ficha"
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
  end

  add_index "ficha_fisioterapia_ninos", ["area_id"], name: "index_ficha_fisioterapia_ninos_on_area_id", using: :btree
  add_index "ficha_fisioterapia_ninos", ["doctor_id"], name: "index_ficha_fisioterapia_ninos_on_doctor_id", using: :btree
  add_index "ficha_fisioterapia_ninos", ["paciente_id"], name: "index_ficha_fisioterapia_ninos_on_paciente_id", using: :btree

  create_table "fichas_fisioterapeuticas_adultos", force: :cascade do |t|
    t.integer  "area_id",                                          null: false
    t.integer  "doctor_id",                                        null: false
    t.integer  "paciente_id",                                      null: false
    t.string   "encargado",               limit: 50,  default: ""
    t.string   "medicamentos",            limit: 250, default: ""
    t.string   "antecedente_actual",      limit: 250, default: ""
    t.string   "antecedente_hereditario", limit: 250, default: ""
    t.string   "condicion_paciente",      limit: 250, default: ""
    t.date     "fecha",                                            null: false
    t.integer  "nro_ficha"
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
  end

  add_index "fichas_fisioterapeuticas_adultos", ["area_id"], name: "index_fichas_fisioterapeuticas_adultos_on_area_id", using: :btree
  add_index "fichas_fisioterapeuticas_adultos", ["doctor_id"], name: "index_fichas_fisioterapeuticas_adultos_on_doctor_id", using: :btree
  add_index "fichas_fisioterapeuticas_adultos", ["paciente_id"], name: "index_fichas_fisioterapeuticas_adultos_on_paciente_id", using: :btree

  create_table "fichas_fonoaudiologicas", force: :cascade do |t|
    t.integer  "paciente_id",                          null: false
    t.integer  "area_id",                              null: false
    t.integer  "doctor_id",                            null: false
    t.string   "escolaridad", limit: 50,  default: ""
    t.string   "escuela",     limit: 100, default: ""
    t.date     "fecha",                                null: false
    t.integer  "nro_ficha"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  add_index "fichas_fonoaudiologicas", ["area_id"], name: "index_fichas_fonoaudiologicas_on_area_id", using: :btree
  add_index "fichas_fonoaudiologicas", ["doctor_id"], name: "index_fichas_fonoaudiologicas_on_doctor_id", using: :btree
  add_index "fichas_fonoaudiologicas", ["paciente_id"], name: "index_fichas_fonoaudiologicas_on_paciente_id", using: :btree

  create_table "fichas_nutricionales_pediatricas", force: :cascade do |t|
    t.integer  "paciente_id"
    t.integer  "area_id"
    t.integer  "profesional_salud_id"
    t.integer  "nro_ficha"
    t.date     "fecha"
    t.string   "problema_embarazo",           limit: 250
    t.string   "control_prenatal",            limit: 250
    t.string   "alimentacion_embarazo",       limit: 250
    t.string   "otros_datos",                 limit: 250
    t.string   "parto_vaginal_cesarea",       limit: 50
    t.string   "termino_pretermino",          limit: 50
    t.string   "lugar_parto",                 limit: 100
    t.string   "como_fue_parto",              limit: 100
    t.string   "peso_nacimiento",             limit: 50
    t.string   "asfixia_lloro",               limit: 250
    t.string   "tomo_pecho",                  limit: 200
    t.string   "alimentacion_complementaria", limit: 100
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
  end

  add_index "fichas_nutricionales_pediatricas", ["area_id"], name: "index_fichas_nutricionales_pediatricas_on_area_id", using: :btree
  add_index "fichas_nutricionales_pediatricas", ["paciente_id"], name: "index_fichas_nutricionales_pediatricas_on_paciente_id", using: :btree
  add_index "fichas_nutricionales_pediatricas", ["profesional_salud_id"], name: "index_fichas_nutricionales_pediatricas_on_profesional_salud_id", using: :btree

  create_table "fichas_psicopedagogicas", force: :cascade do |t|
    t.integer  "paciente_id",                          null: false
    t.integer  "area_id",                              null: false
    t.integer  "doctor_id",                            null: false
    t.string   "escolaridad", limit: 50,  default: ""
    t.string   "escuela",     limit: 100, default: ""
    t.date     "fecha",                                null: false
    t.integer  "nro_ficha"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  add_index "fichas_psicopedagogicas", ["area_id"], name: "index_fichas_psicopedagogicas_on_area_id", using: :btree
  add_index "fichas_psicopedagogicas", ["doctor_id"], name: "index_fichas_psicopedagogicas_on_doctor_id", using: :btree
  add_index "fichas_psicopedagogicas", ["paciente_id"], name: "index_fichas_psicopedagogicas_on_paciente_id", using: :btree

  create_table "grupos", force: :cascade do |t|
    t.string   "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "horarios", force: :cascade do |t|
    t.integer  "empleado_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "horarios", ["empleado_id"], name: "index_horarios_on_empleado_id", using: :btree

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

  add_index "pacientes", ["encargado_id"], name: "index_pacientes_on_encargado_id", using: :btree
  add_index "pacientes", ["persona_id"], name: "index_pacientes_on_persona_id", using: :btree

  create_table "permissions", force: :cascade do |t|
    t.integer  "grupo_id"
    t.string   "model"
    t.string   "nombre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "permissions", ["grupo_id"], name: "index_permissions_on_grupo_id", using: :btree

  create_table "permissions_roles", force: :cascade do |t|
    t.integer  "role_id"
    t.integer  "permission_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "permissions_roles", ["permission_id"], name: "index_permissions_roles_on_permission_id", using: :btree
  add_index "permissions_roles", ["role_id"], name: "index_permissions_roles_on_role_id", using: :btree

  create_table "personas", force: :cascade do |t|
    t.string   "ci",               limit: 15,  default: "", null: false
    t.string   "nombre",           limit: 30,  default: "", null: false
    t.string   "apellido",         limit: 30,  default: "", null: false
    t.string   "direccion",        limit: 125, default: ""
    t.string   "telefono",         limit: 50,  default: ""
    t.string   "email",            limit: 50,  default: ""
    t.string   "ruc",              limit: 20,  default: ""
    t.date     "fecha_nacimiento"
    t.string   "sexo",             limit: 9,   default: ""
    t.string   "edad",             limit: 3,   default: ""
    t.string   "nacionalidad",     limit: 20,  default: ""
    t.integer  "estado_civil_id"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "personas", ["deleted_at"], name: "index_personas_on_deleted_at", unique: true, using: :btree
  add_index "personas", ["estado_civil_id"], name: "index_personas_on_estado_civil_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "titulo_largos", force: :cascade do |t|
    t.string   "titulo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "turnos", force: :cascade do |t|
    t.integer  "paciente_id",      null: false
    t.date     "fecha_expedicion", null: false
    t.date     "fecha_consulta",   null: false
    t.integer  "area_id",          null: false
    t.integer  "doctor_id",        null: false
    t.string   "estado",           null: false
    t.integer  "monto"
    t.boolean  "paga",             null: false
    t.string   "nro_factura"
    t.integer  "turno"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "turnos", ["area_id"], name: "index_turnos_on_area_id", using: :btree
  add_index "turnos", ["doctor_id"], name: "index_turnos_on_doctor_id", using: :btree
  add_index "turnos", ["paciente_id"], name: "index_turnos_on_paciente_id", using: :btree

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

  add_index "users", ["empleado_id"], name: "index_users_on_empleado_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

  add_foreign_key "consultas", "areas", on_delete: :restrict
  add_foreign_key "consultas", "empleados", column: "profesional_salud_id", on_delete: :restrict
  add_foreign_key "consultas", "pacientes", on_delete: :cascade
  add_foreign_key "empleados", "areas", on_delete: :restrict
  add_foreign_key "empleados", "personas", on_delete: :restrict
  add_foreign_key "fechas", "horarios", on_delete: :restrict
  add_foreign_key "ficha_fisioterapia_ninos", "areas", on_delete: :restrict
  add_foreign_key "ficha_fisioterapia_ninos", "pacientes", on_delete: :restrict
  add_foreign_key "fichas_fisioterapeuticas_adultos", "areas", on_delete: :restrict
  add_foreign_key "fichas_fisioterapeuticas_adultos", "pacientes", on_delete: :restrict
  add_foreign_key "fichas_fonoaudiologicas", "areas", on_delete: :restrict
  add_foreign_key "fichas_fonoaudiologicas", "pacientes", on_delete: :restrict
  add_foreign_key "fichas_nutricionales_pediatricas", "areas", on_delete: :restrict
  add_foreign_key "fichas_nutricionales_pediatricas", "pacientes", on_delete: :restrict
  add_foreign_key "fichas_psicopedagogicas", "areas", on_delete: :restrict
  add_foreign_key "fichas_psicopedagogicas", "pacientes", on_delete: :restrict
  add_foreign_key "horarios", "empleados", on_delete: :cascade
  add_foreign_key "pacientes", "encargados", on_delete: :restrict
  add_foreign_key "pacientes", "personas", on_delete: :restrict
  add_foreign_key "permissions", "grupos", on_delete: :restrict
  add_foreign_key "permissions_roles", "permissions"
  add_foreign_key "permissions_roles", "roles"
  add_foreign_key "personas", "estados_civiles", on_delete: :restrict
  add_foreign_key "turnos", "areas", on_delete: :restrict
  add_foreign_key "turnos", "empleados", column: "doctor_id", on_delete: :restrict
  add_foreign_key "turnos", "pacientes", on_delete: :restrict
  add_foreign_key "users", "empleados", on_delete: :restrict
end
