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

ActiveRecord::Schema.define(version: 20160527060755) do

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
    t.integer  "doctor_id"
    t.integer  "paciente_id",                              null: false
    t.integer  "area_id",                                  null: false
    t.date     "fecha"
    t.string   "motivo_consulta", limit: 300, default: ""
    t.string   "evaluacion",      limit: 300, default: ""
    t.string   "tratamiento",     limit: 600, default: ""
    t.string   "observaciones",   limit: 250, default: ""
    t.datetime "deleted_at"
  end

  add_index "consultas", ["area_id"], name: "index_consultas_on_area_id", using: :btree
  add_index "consultas", ["doctor_id"], name: "index_consultas_on_doctor_id", using: :btree
  add_index "consultas", ["paciente_id"], name: "index_consultas_on_paciente_id", using: :btree

  create_table "consultas_nutricionales_adultos", force: :cascade do |t|
    t.integer  "ficha_nutricional_adulto_id",             null: false
    t.integer  "doctor_id",                               null: false
    t.date     "fecha",                                   null: false
    t.string   "motivo_consulta",             limit: 250
    t.string   "actuales",                    limit: 200
    t.string   "dx",                          limit: 250
    t.string   "peso_actual",                 limit: 10
    t.string   "peso_ideal",                  limit: 10
    t.string   "peso_deseable",               limit: 10
    t.string   "talla",                       limit: 10
    t.string   "biotipo",                     limit: 50
    t.string   "cir_muneca",                  limit: 50
    t.string   "circ_brazo",                  limit: 50
    t.string   "circ_cintura",                limit: 50
    t.string   "imc",                         limit: 50
    t.string   "evaluacion",                  limit: 250
    t.string   "medicamentos",                limit: 100
    t.string   "suplementos",                 limit: 50
    t.string   "apetito",                     limit: 10
    t.string   "factores_apetito",            limit: 150
    t.string   "alergia_intolerancia",        limit: 150
    t.string   "cae_cabello",                 limit: 10
    t.string   "estado_bucal",                limit: 250
    t.string   "orina_bien",                  limit: 50
    t.string   "ir_cuerpo",                   limit: 50
    t.boolean  "actividades_fisicas"
    t.string   "tipo",                        limit: 100
    t.string   "hs_act_fisicas",              limit: 50
    t.string   "frecuencia",                  limit: 50
    t.string   "actividad_laboral",           limit: 150
    t.string   "horas_laborales",             limit: 50
    t.string   "vive_con",                    limit: 100
    t.string   "quien_prepara",               limit: 50
    t.string   "que_elementos",               limit: 150
    t.string   "toma_agua",                   limit: 100
    t.string   "mastica_deglute",             limit: 50
    t.string   "dificultad_beber",            limit: 100
    t.string   "hora_acuesta",                limit: 10
    t.string   "hora_levanta",                limit: 10
    t.string   "duerme_bien",                 limit: 50
    t.string   "habilidades",                 limit: 150
    t.string   "tratamientos_cenade",         limit: 150
    t.string   "alim_desayuno",               limit: 200
    t.string   "alim_media",                  limit: 200
    t.string   "alim_almuerzo",               limit: 200
    t.string   "alim_merienda",               limit: 200
    t.string   "alim_cena",                   limit: 200
    t.string   "cant_desayuno",               limit: 50
    t.string   "cant_media",                  limit: 50
    t.string   "cant_almuerzo",               limit: 50
    t.string   "cant_merienda",               limit: 50
    t.string   "cant_cena",                   limit: 50
    t.string   "modo_desayuno",               limit: 250
    t.string   "modo_media",                  limit: 250
    t.string   "modo_almuerzo",               limit: 250
    t.string   "modo_merienda",               limit: 250
    t.string   "modo_cena",                   limit: 250
    t.string   "lugar_desayuno",              limit: 250
    t.string   "lugar_media",                 limit: 250
    t.string   "lugar_almuerzo",              limit: 250
    t.string   "lugar_merienda",              limit: 250
    t.string   "lugar_cena",                  limit: 250
    t.string   "indicaciones",                limit: 250
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
  end

  add_index "consultas_nutricionales_adultos", ["doctor_id"], name: "index_consultas_nutricionales_adultos_on_doctor_id", using: :btree
  add_index "consultas_nutricionales_adultos", ["ficha_nutricional_adulto_id"], name: "ficha_id", using: :btree

  create_table "consultas_nutricionales_pediatricas", force: :cascade do |t|
    t.integer  "area_id",                             null: false
    t.integer  "doctor_id",                           null: false
    t.integer  "ficha_nutri_ped_id",                  null: false
    t.date     "fecha",                               null: false
    t.string   "sosten_cefalico",         limit: 100
    t.string   "sento",                   limit: 7
    t.string   "paro",                    limit: 7
    t.string   "camino",                  limit: 7
    t.string   "sigue_luz",               limit: 50
    t.string   "busca_sonido",            limit: 50
    t.string   "rie_llora",               limit: 50
    t.string   "emite_sonido",            limit: 50
    t.string   "habilidades",             limit: 200
    t.string   "mastica_deglute",         limit: 100
    t.string   "otros",                   limit: 250
    t.string   "desayuno",                limit: 250
    t.string   "media_manana",            limit: 250
    t.string   "almuerzo",                limit: 250
    t.string   "merienda",                limit: 250
    t.string   "cena",                    limit: 250
    t.string   "encargado",               limit: 100
    t.string   "diarrea",                 limit: 50
    t.string   "vomitos",                 limit: 50
    t.string   "fiebre",                  limit: 50
    t.string   "constipacion",            limit: 100
    t.string   "orina",                   limit: 100
    t.string   "sudor",                   limit: 100
    t.string   "problemas_respiratorios", limit: 100
    t.string   "distension_abdominal",    limit: 100
    t.string   "otros2",                  limit: 200
    t.string   "diagnostico",             limit: 250
    t.string   "peso",                    limit: 10
    t.string   "talla",                   limit: 10
    t.string   "pc",                      limit: 10
    t.string   "imc",                     limit: 10
    t.string   "cm",                      limit: 10
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "consultas_nutricionales_pediatricas", ["area_id"], name: "index_consultas_nutricionales_pediatricas_on_area_id", using: :btree
  add_index "consultas_nutricionales_pediatricas", ["ficha_nutri_ped_id"], name: "index_consultas_nutricionales_pediatricas_on_ficha_nutri_ped_id", using: :btree

  create_table "consultas_odontologicas", force: :cascade do |t|
    t.integer  "area_id",                               null: false
    t.integer  "doctor_id",                             null: false
    t.integer  "ficha_odontologica_id",                 null: false
    t.date     "fecha",                                 null: false
    t.string   "motivo_consulta",           limit: 250
    t.string   "observaciones",             limit: 250
    t.string   "servicio_cenade",           limit: 250
    t.string   "medicacion_actual",         limit: 250
    t.string   "anestesico",                limit: 50
    t.string   "penicilina",                limit: 50
    t.string   "otros_medicamentos",        limit: 50
    t.string   "hemorragias",               limit: 250
    t.string   "problema_tratamiento",      limit: 250
    t.string   "enfermedad_cardiovascular", limit: 250
    t.string   "diabetes",                  limit: 50
    t.string   "hepatitis",                 limit: 50
    t.string   "enfermedades_renales",      limit: 50
    t.string   "artritis",                  limit: 50
    t.string   "tuberculosis",              limit: 50
    t.string   "enfermedades_venereas",     limit: 50
    t.string   "enfermedades_sanguineas",   limit: 50
    t.string   "fumador",                   limit: 50
    t.string   "enfermedades_neurologicas", limit: 50
    t.string   "menstruacion",              limit: 50
    t.string   "embarazada",                limit: 50
    t.string   "tiene_hijos",               limit: 50
    t.string   "cantidad_hijos",            limit: 2
    t.string   "amamanta",                  limit: 50
    t.string   "hospitalizado",             limit: 50
    t.string   "causa_hospitalizado",       limit: 50
    t.string   "ecg",                       limit: 50
    t.string   "tac",                       limit: 50
    t.string   "rx",                        limit: 50
    t.string   "laboratorios",              limit: 50
    t.string   "otros_examenes",            limit: 50
    t.string   "tratamiento",               limit: 250
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  add_index "consultas_odontologicas", ["area_id"], name: "index_consultas_odontologicas_on_area_id", using: :btree
  add_index "consultas_odontologicas", ["ficha_odontologica_id"], name: "index_consultas_odontologicas_on_ficha_odontologica_id", using: :btree

  create_table "controles", force: :cascade do |t|
    t.integer  "consulta_nutricional_pediatrica_id"
    t.integer  "doctor_id",                                                   null: false
    t.integer  "area_id",                                                     null: false
    t.integer  "paciente_id",                                                 null: false
    t.date     "fecha",                                                       null: false
    t.string   "tratamiento",                        limit: 300, default: ""
    t.string   "observaciones",                      limit: 300, default: ""
    t.datetime "created_at",                                                  null: false
    t.datetime "updated_at",                                                  null: false
  end

  add_index "controles", ["area_id"], name: "index_controles_on_area_id", using: :btree
  add_index "controles", ["paciente_id"], name: "index_controles_on_paciente_id", using: :btree

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

  add_index "encargados", ["paciente_id"], name: "index_encargados_on_paciente_id", using: :btree

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

  create_table "fichas_clinicos", force: :cascade do |t|
    t.integer  "paciente_id",                                      null: false
    t.integer  "area_id",                                          null: false
    t.integer  "doctor_id",                                        null: false
    t.string   "p",                       limit: 10,  default: ""
    t.string   "a",                       limit: 10,  default: ""
    t.string   "pc1",                     limit: 10,  default: ""
    t.string   "pt1",                     limit: 50,  default: ""
    t.string   "pa",                      limit: 10,  default: ""
    t.string   "control",                 limit: 250, default: ""
    t.string   "gestacion",               limit: 100, default: ""
    t.string   "paridad",                 limit: 100, default: ""
    t.string   "abortos",                 limit: 100, default: ""
    t.string   "nacidos_muertos",         limit: 100, default: ""
    t.string   "partos_anteriores",       limit: 100, default: ""
    t.string   "gru_san_paciente",        limit: 10,  default: ""
    t.string   "rh_paciente",             limit: 10,  default: ""
    t.string   "coombs",                  limit: 10,  default: ""
    t.string   "gru_san_padre",           limit: 10,  default: ""
    t.string   "rh_padre",                limit: 10,  default: ""
    t.string   "fum",                     limit: 50,  default: ""
    t.string   "fp",                      limit: 50,  default: ""
    t.string   "duracion",                limit: 50,  default: ""
    t.string   "riesgos",                 limit: 50,  default: ""
    t.string   "tipo_parto",              limit: 50,  default: ""
    t.string   "anestesia",               limit: 50,  default: ""
    t.string   "analgesia",               limit: 50,  default: ""
    t.string   "neonatal_cianosis",       limit: 50,  default: ""
    t.string   "ictericia_antes",         limit: 50,  default: ""
    t.string   "ictericia_despues",       limit: 50,  default: ""
    t.string   "apgar",                   limit: 50,  default: ""
    t.string   "peso1",                   limit: 50,  default: ""
    t.string   "talla1",                  limit: 50,  default: ""
    t.string   "pc2",                     limit: 50,  default: ""
    t.string   "tp",                      limit: 50,  default: ""
    t.string   "fontanela",               limit: 50,  default: ""
    t.string   "dubowitz",                limit: 50,  default: ""
    t.string   "parkin",                  limit: 50,  default: ""
    t.string   "gru_san2",                limit: 10,  default: ""
    t.string   "rh2",                     limit: 10,  default: ""
    t.string   "medicacion",              limit: 50,  default: ""
    t.string   "ccu",                     limit: 50,  default: ""
    t.string   "tiempo_internacion",      limit: 50,  default: ""
    t.string   "alta",                    limit: 50,  default: ""
    t.string   "peso2",                   limit: 50,  default: ""
    t.string   "talla2",                  limit: 50,  default: ""
    t.string   "pb",                      limit: 50,  default: ""
    t.string   "alimentacion_natural",    limit: 100, default: ""
    t.string   "alimentacion_artificial", limit: 100, default: ""
    t.string   "bcg",                     limit: 50,  default: ""
    t.string   "antisarampionosa",        limit: 50,  default: ""
    t.string   "antigripal",              limit: 50,  default: ""
    t.string   "mmr",                     limit: 50,  default: ""
    t.string   "dpt",                     limit: 20,  default: ""
    t.string   "dpt1",                    limit: 20,  default: ""
    t.string   "dpt2",                    limit: 50,  default: ""
    t.string   "dpt3",                    limit: 20,  default: ""
    t.string   "dpt_ref1",                limit: 20,  default: ""
    t.string   "dpt_ref2",                limit: 20,  default: ""
    t.string   "dpt_ref3",                limit: 20,  default: ""
    t.string   "dpt_ref4",                limit: 20,  default: ""
    t.string   "sabin",                   limit: 20,  default: ""
    t.string   "sabin1",                  limit: 20,  default: ""
    t.string   "sabin2",                  limit: 20,  default: ""
    t.string   "sabin3",                  limit: 20,  default: ""
    t.string   "sabin_ref1",              limit: 20,  default: ""
    t.string   "sabin_ref2",              limit: 20,  default: ""
    t.string   "sabin_ref3",              limit: 20,  default: ""
    t.string   "sabin_ref4",              limit: 20,  default: ""
    t.string   "otras",                   limit: 50,  default: ""
    t.string   "app",                     limit: 50,  default: ""
    t.string   "apf",                     limit: 50,  default: ""
    t.string   "edad_mental",             limit: 50,  default: ""
    t.string   "epl",                     limit: 50,  default: ""
    t.string   "dpm",                     limit: 50,  default: ""
    t.string   "tto_ant",                 limit: 50,  default: ""
    t.string   "sosten_cefalico",         limit: 50,  default: ""
    t.string   "sedentacion",             limit: 50,  default: ""
    t.string   "mancha",                  limit: 50,  default: ""
    t.date     "fecha",                                            null: false
    t.integer  "nro_ficha"
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
  end

  add_index "fichas_clinicos", ["area_id"], name: "index_fichas_clinicos_on_area_id", using: :btree
  add_index "fichas_clinicos", ["doctor_id"], name: "index_fichas_clinicos_on_doctor_id", using: :btree
  add_index "fichas_clinicos", ["paciente_id"], name: "index_fichas_clinicos_on_paciente_id", using: :btree

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

  create_table "fichas_neurologicas", force: :cascade do |t|
    t.integer  "paciente_id",                                      null: false
    t.integer  "area_id",                                          null: false
    t.integer  "doctor_id",                                        null: false
    t.string   "p",                       limit: 10,  default: ""
    t.string   "a",                       limit: 10,  default: ""
    t.string   "pc1",                     limit: 10,  default: ""
    t.string   "pt1",                     limit: 50,  default: ""
    t.string   "pa",                      limit: 10,  default: ""
    t.string   "control",                 limit: 250, default: ""
    t.string   "gestacion",               limit: 100, default: ""
    t.string   "paridad",                 limit: 100, default: ""
    t.string   "abortos",                 limit: 100, default: ""
    t.string   "nacidos_muertos",         limit: 100, default: ""
    t.string   "partos_anteriores",       limit: 100, default: ""
    t.string   "gru_san_paciente",        limit: 10,  default: ""
    t.string   "rh_paciente",             limit: 10,  default: ""
    t.string   "coombs",                  limit: 10,  default: ""
    t.string   "gru_san_padre",           limit: 10,  default: ""
    t.string   "rh_padre",                limit: 10,  default: ""
    t.string   "fum",                     limit: 50,  default: ""
    t.string   "fp",                      limit: 50,  default: ""
    t.string   "duracion",                limit: 50,  default: ""
    t.string   "riesgos",                 limit: 50,  default: ""
    t.string   "tipo_parto",              limit: 50,  default: ""
    t.string   "anestesia",               limit: 50,  default: ""
    t.string   "analgesia",               limit: 50,  default: ""
    t.string   "neonatal_cianosis",       limit: 50,  default: ""
    t.string   "ictericia_antes",         limit: 50,  default: ""
    t.string   "ictericia_despues",       limit: 50,  default: ""
    t.string   "apgar",                   limit: 50,  default: ""
    t.string   "peso1",                   limit: 50,  default: ""
    t.string   "talla1",                  limit: 50,  default: ""
    t.string   "pc2",                     limit: 50,  default: ""
    t.string   "tp",                      limit: 50,  default: ""
    t.string   "fontanela",               limit: 50,  default: ""
    t.string   "dubowitz",                limit: 50,  default: ""
    t.string   "parkin",                  limit: 50,  default: ""
    t.string   "gru_san2",                limit: 10,  default: ""
    t.string   "rh2",                     limit: 10,  default: ""
    t.string   "medicacion",              limit: 50,  default: ""
    t.string   "ccu",                     limit: 50,  default: ""
    t.string   "tiempo_internacion",      limit: 50,  default: ""
    t.string   "alta",                    limit: 50,  default: ""
    t.string   "peso2",                   limit: 50,  default: ""
    t.string   "talla2",                  limit: 50,  default: ""
    t.string   "pb",                      limit: 50,  default: ""
    t.string   "alimentacion_natural",    limit: 100, default: ""
    t.string   "alimentacion_artificial", limit: 100, default: ""
    t.string   "bcg",                     limit: 50,  default: ""
    t.string   "antisarampionosa",        limit: 50,  default: ""
    t.string   "antigripal",              limit: 50,  default: ""
    t.string   "mmr",                     limit: 50,  default: ""
    t.string   "dpt",                     limit: 20,  default: ""
    t.string   "dpt1",                    limit: 20,  default: ""
    t.string   "dpt2",                    limit: 50,  default: ""
    t.string   "dpt3",                    limit: 20,  default: ""
    t.string   "dpt_ref1",                limit: 20,  default: ""
    t.string   "dpt_ref2",                limit: 20,  default: ""
    t.string   "dpt_ref3",                limit: 20,  default: ""
    t.string   "dpt_ref4",                limit: 20,  default: ""
    t.string   "sabin",                   limit: 20,  default: ""
    t.string   "sabin1",                  limit: 20,  default: ""
    t.string   "sabin2",                  limit: 20,  default: ""
    t.string   "sabin3",                  limit: 20,  default: ""
    t.string   "sabin_ref1",              limit: 20,  default: ""
    t.string   "sabin_ref2",              limit: 20,  default: ""
    t.string   "sabin_ref3",              limit: 20,  default: ""
    t.string   "sabin_ref4",              limit: 20,  default: ""
    t.string   "otras",                   limit: 50,  default: ""
    t.string   "app",                     limit: 50,  default: ""
    t.string   "apf",                     limit: 50,  default: ""
    t.string   "edad_mental",             limit: 50,  default: ""
    t.string   "epl",                     limit: 50,  default: ""
    t.string   "dpm",                     limit: 50,  default: ""
    t.string   "tto_ant",                 limit: 50,  default: ""
    t.string   "sosten_cefalico",         limit: 50,  default: ""
    t.string   "sedentacion",             limit: 50,  default: ""
    t.string   "mancha",                  limit: 50,  default: ""
    t.date     "fecha",                                            null: false
    t.integer  "nro_ficha"
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
  end

  add_index "fichas_neurologicas", ["area_id"], name: "index_fichas_neurologicas_on_area_id", using: :btree
  add_index "fichas_neurologicas", ["doctor_id"], name: "index_fichas_neurologicas_on_doctor_id", using: :btree
  add_index "fichas_neurologicas", ["paciente_id"], name: "index_fichas_neurologicas_on_paciente_id", using: :btree

  create_table "fichas_nutricionales_adultos", force: :cascade do |t|
    t.integer  "paciente_id",              null: false
    t.integer  "area_id",                  null: false
    t.integer  "doctor_id",                null: false
    t.date     "fecha",                    null: false
    t.integer  "nro_ficha"
    t.integer  "nro_hijos",    limit: 2
    t.string   "obesidad",     limit: 50
    t.string   "dbt",          limit: 50
    t.string   "hta",          limit: 50
    t.string   "cardiopatias", limit: 50
    t.string   "actuales",     limit: 200
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "fichas_nutricionales_adultos", ["area_id"], name: "index_fichas_nutricionales_adultos_on_area_id", using: :btree
  add_index "fichas_nutricionales_adultos", ["doctor_id"], name: "index_fichas_nutricionales_adultos_on_doctor_id", using: :btree
  add_index "fichas_nutricionales_adultos", ["paciente_id"], name: "index_fichas_nutricionales_adultos_on_paciente_id", using: :btree

  create_table "fichas_nutricionales_pediatricas", force: :cascade do |t|
    t.integer  "paciente_id",                             null: false
    t.integer  "area_id",                                 null: false
    t.integer  "profesional_salud_id",                    null: false
    t.integer  "nro_ficha"
    t.date     "fecha",                                   null: false
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

  create_table "fichas_odontologicas", force: :cascade do |t|
    t.integer  "paciente_id",                          null: false
    t.integer  "area_id",                              null: false
    t.integer  "doctor_id",                            null: false
    t.integer  "nro_ficha"
    t.date     "fecha",                                null: false
    t.string   "nombre_tutor", limit: 30, default: ""
    t.string   "tel_tutor",    limit: 50, default: ""
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  add_index "fichas_odontologicas", ["area_id"], name: "index_fichas_odontologicas_on_area_id", using: :btree
  add_index "fichas_odontologicas", ["doctor_id"], name: "index_fichas_odontologicas_on_doctor_id", using: :btree
  add_index "fichas_odontologicas", ["paciente_id"], name: "index_fichas_odontologicas_on_paciente_id", using: :btree

  create_table "fichas_pediatricas", force: :cascade do |t|
    t.integer  "paciente_id",                                      null: false
    t.integer  "area_id",                                          null: false
    t.integer  "doctor_id",                                        null: false
    t.string   "p",                       limit: 10,  default: ""
    t.string   "a",                       limit: 10,  default: ""
    t.string   "pc1",                     limit: 10,  default: ""
    t.string   "pt1",                     limit: 50,  default: ""
    t.string   "pa",                      limit: 10,  default: ""
    t.string   "control",                 limit: 250, default: ""
    t.string   "gestacion",               limit: 100, default: ""
    t.string   "paridad",                 limit: 100, default: ""
    t.string   "abortos",                 limit: 100, default: ""
    t.string   "nacidos_muertos",         limit: 100, default: ""
    t.string   "partos_anteriores",       limit: 100, default: ""
    t.string   "gru_san_paciente",        limit: 10,  default: ""
    t.string   "rh_paciente",             limit: 10,  default: ""
    t.string   "coombs",                  limit: 10,  default: ""
    t.string   "gru_san_padre",           limit: 10,  default: ""
    t.string   "rh_padre",                limit: 10,  default: ""
    t.string   "fum",                     limit: 50,  default: ""
    t.string   "fp",                      limit: 50,  default: ""
    t.string   "duracion",                limit: 50,  default: ""
    t.string   "riesgos",                 limit: 50,  default: ""
    t.string   "tipo_parto",              limit: 50,  default: ""
    t.string   "anestesia",               limit: 50,  default: ""
    t.string   "analgesia",               limit: 50,  default: ""
    t.string   "neonatal_cianosis",       limit: 50,  default: ""
    t.string   "ictericia_antes",         limit: 50,  default: ""
    t.string   "ictericia_despues",       limit: 50,  default: ""
    t.string   "apgar",                   limit: 50,  default: ""
    t.string   "peso1",                   limit: 50,  default: ""
    t.string   "talla1",                  limit: 50,  default: ""
    t.string   "pc2",                     limit: 50,  default: ""
    t.string   "tp",                      limit: 50,  default: ""
    t.string   "fontanela",               limit: 50,  default: ""
    t.string   "dubowitz",                limit: 50,  default: ""
    t.string   "parkin",                  limit: 50,  default: ""
    t.string   "gru_san2",                limit: 10,  default: ""
    t.string   "rh2",                     limit: 10,  default: ""
    t.string   "medicacion",              limit: 50,  default: ""
    t.string   "ccu",                     limit: 50,  default: ""
    t.string   "tiempo_internacion",      limit: 50,  default: ""
    t.string   "alta",                    limit: 50,  default: ""
    t.string   "peso2",                   limit: 50,  default: ""
    t.string   "talla2",                  limit: 50,  default: ""
    t.string   "pb",                      limit: 50,  default: ""
    t.string   "alimentacion_natural",    limit: 100, default: ""
    t.string   "alimentacion_artificial", limit: 100, default: ""
    t.string   "bcg",                     limit: 50,  default: ""
    t.string   "antisarampionosa",        limit: 50,  default: ""
    t.string   "antigripal",              limit: 50,  default: ""
    t.string   "mmr",                     limit: 50,  default: ""
    t.string   "dpt",                     limit: 20,  default: ""
    t.string   "dpt1",                    limit: 20,  default: ""
    t.string   "dpt2",                    limit: 50,  default: ""
    t.string   "dpt3",                    limit: 20,  default: ""
    t.string   "dpt_ref1",                limit: 20,  default: ""
    t.string   "dpt_ref2",                limit: 20,  default: ""
    t.string   "dpt_ref3",                limit: 20,  default: ""
    t.string   "dpt_ref4",                limit: 20,  default: ""
    t.string   "sabin",                   limit: 20,  default: ""
    t.string   "sabin1",                  limit: 20,  default: ""
    t.string   "sabin2",                  limit: 20,  default: ""
    t.string   "sabin3",                  limit: 20,  default: ""
    t.string   "sabin_ref1",              limit: 20,  default: ""
    t.string   "sabin_ref2",              limit: 20,  default: ""
    t.string   "sabin_ref3",              limit: 20,  default: ""
    t.string   "sabin_ref4",              limit: 20,  default: ""
    t.string   "otras",                   limit: 50,  default: ""
    t.string   "app",                     limit: 50,  default: ""
    t.string   "apf",                     limit: 50,  default: ""
    t.string   "edad_mental",             limit: 50,  default: ""
    t.string   "epl",                     limit: 50,  default: ""
    t.string   "dpm",                     limit: 50,  default: ""
    t.string   "tto_ant",                 limit: 50,  default: ""
    t.string   "sosten_cefalico",         limit: 50,  default: ""
    t.string   "sedentacion",             limit: 50,  default: ""
    t.string   "mancha",                  limit: 50,  default: ""
    t.date     "fecha",                                            null: false
    t.integer  "nro_ficha"
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
  end

  add_index "fichas_pediatricas", ["area_id"], name: "index_fichas_pediatricas_on_area_id", using: :btree
  add_index "fichas_pediatricas", ["doctor_id"], name: "index_fichas_pediatricas_on_doctor_id", using: :btree
  add_index "fichas_pediatricas", ["paciente_id"], name: "index_fichas_pediatricas_on_paciente_id", using: :btree

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

  create_table "recuentos", force: :cascade do |t|
    t.integer  "consulta_nutricional_adulto_id",             null: false
    t.string   "comidas_turnos",                 limit: 50
    t.string   "hora",                           limit: 10
    t.string   "alimentos",                      limit: 250
    t.integer  "cantidad"
    t.string   "modo_preparacion",               limit: 500
    t.string   "lugar_consumo",                  limit: 200
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  add_index "recuentos", ["consulta_nutricional_adulto_id"], name: "consulta_id", using: :btree

  create_table "reportes_estadisticos", force: :cascade do |t|
    t.integer  "area_id",               null: false
    t.string   "mes",        limit: 10, null: false
    t.integer  "anho",                  null: false
    t.integer  "doctor_id",             null: false
    t.integer  "cantidad"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "reportes_estadisticos", ["area_id"], name: "index_reportes_estadisticos_on_area_id", using: :btree
  add_index "reportes_estadisticos", ["doctor_id"], name: "index_reportes_estadisticos_on_doctor_id", using: :btree

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
  add_foreign_key "consultas", "empleados", column: "doctor_id", on_delete: :restrict
  add_foreign_key "consultas", "pacientes", on_delete: :cascade
  add_foreign_key "consultas_nutricionales_pediatricas", "areas", on_delete: :restrict
  add_foreign_key "consultas_nutricionales_pediatricas", "fichas_nutricionales_pediatricas", column: "ficha_nutri_ped_id", on_delete: :restrict
  add_foreign_key "consultas_odontologicas", "areas", on_delete: :restrict
  add_foreign_key "consultas_odontologicas", "fichas_odontologicas", on_delete: :restrict
  add_foreign_key "controles", "areas", on_delete: :restrict
  add_foreign_key "controles", "consultas_nutricionales_pediatricas", on_delete: :restrict
  add_foreign_key "controles", "pacientes", on_delete: :restrict
  add_foreign_key "empleados", "areas", on_delete: :restrict
  add_foreign_key "empleados", "personas", on_delete: :restrict
  add_foreign_key "fechas", "horarios", on_delete: :restrict
  add_foreign_key "ficha_fisioterapia_ninos", "areas", on_delete: :restrict
  add_foreign_key "ficha_fisioterapia_ninos", "pacientes", on_delete: :restrict
  add_foreign_key "fichas_clinicos", "areas", on_delete: :restrict
  add_foreign_key "fichas_clinicos", "pacientes", on_delete: :restrict
  add_foreign_key "fichas_fisioterapeuticas_adultos", "areas", on_delete: :restrict
  add_foreign_key "fichas_fisioterapeuticas_adultos", "pacientes", on_delete: :restrict
  add_foreign_key "fichas_fonoaudiologicas", "areas", on_delete: :restrict
  add_foreign_key "fichas_fonoaudiologicas", "pacientes", on_delete: :restrict
  add_foreign_key "fichas_neurologicas", "areas", on_delete: :restrict
  add_foreign_key "fichas_neurologicas", "pacientes", on_delete: :restrict
  add_foreign_key "fichas_nutricionales_adultos", "areas", on_delete: :restrict
  add_foreign_key "fichas_nutricionales_adultos", "pacientes", on_delete: :restrict
  add_foreign_key "fichas_nutricionales_pediatricas", "areas", on_delete: :restrict
  add_foreign_key "fichas_nutricionales_pediatricas", "pacientes", on_delete: :restrict
  add_foreign_key "fichas_odontologicas", "areas", on_delete: :restrict
  add_foreign_key "fichas_odontologicas", "pacientes", on_delete: :restrict
  add_foreign_key "fichas_pediatricas", "areas", on_delete: :restrict
  add_foreign_key "fichas_pediatricas", "pacientes", on_delete: :restrict
  add_foreign_key "fichas_psicopedagogicas", "areas", on_delete: :restrict
  add_foreign_key "fichas_psicopedagogicas", "pacientes", on_delete: :restrict
  add_foreign_key "horarios", "empleados", on_delete: :cascade
  add_foreign_key "pacientes", "encargados", on_delete: :restrict
  add_foreign_key "pacientes", "personas", on_delete: :restrict
  add_foreign_key "permissions", "grupos", on_delete: :restrict
  add_foreign_key "permissions_roles", "permissions"
  add_foreign_key "permissions_roles", "roles"
  add_foreign_key "personas", "estados_civiles", on_delete: :restrict
  add_foreign_key "reportes_estadisticos", "areas", on_delete: :restrict
  add_foreign_key "turnos", "areas", on_delete: :restrict
  add_foreign_key "turnos", "empleados", column: "doctor_id", on_delete: :restrict
  add_foreign_key "turnos", "pacientes", on_delete: :restrict
  add_foreign_key "users", "empleados", on_delete: :restrict
end
