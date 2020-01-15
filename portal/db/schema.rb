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

ActiveRecord::Schema.define(version: 2020_01_14_004408) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "audits", force: :cascade do |t|
    t.integer "auditable_id"
    t.string "auditable_type"
    t.integer "associated_id"
    t.string "associated_type"
    t.integer "user_id"
    t.string "user_type"
    t.string "username"
    t.string "action"
    t.text "audited_changes"
    t.integer "version", default: 0
    t.string "comment"
    t.string "remote_address"
    t.string "request_uuid"
    t.datetime "created_at"
    t.index ["associated_type", "associated_id"], name: "associated_index"
    t.index ["auditable_type", "auditable_id", "version"], name: "auditable_index"
    t.index ["created_at"], name: "index_audits_on_created_at"
    t.index ["request_uuid"], name: "index_audits_on_request_uuid"
    t.index ["user_id", "user_type"], name: "user_index"
  end

  create_table "tb_avaliacoes", force: :cascade do |t|
    t.integer "tb_empregado_id"
    t.integer "tb_empregado_gerente_id"
    t.decimal "media"
    t.datetime "dta_finalizacao"
    t.integer "status", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["status"], name: "index_tb_avaliacoes_on_status"
  end

  create_table "tb_cargos", force: :cascade do |t|
    t.string "nome"
    t.decimal "salario"
    t.string "chave"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chave"], name: "index_tb_cargos_on_chave"
  end

  create_table "tb_empregados", force: :cascade do |t|
    t.string "nome"
    t.string "nmr_cpf"
    t.string "end_email"
    t.date "dta_nascimento"
    t.integer "sexo"
    t.date "dta_admissao"
    t.integer "tb_cargo_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tb_perguntas", force: :cascade do |t|
    t.string "nme_pergunta"
    t.string "descricao"
    t.integer "peso"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tb_respostas", force: :cascade do |t|
    t.integer "tb_avaliacao_id"
    t.integer "tb_pergunta_id"
    t.integer "nota"
    t.text "obs"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "useres", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.boolean "e_admin", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "tb_empregado_id", comment: "FK TbEmpregado table"
    t.index ["email"], name: "index_useres_on_email", unique: true
    t.index ["reset_password_token"], name: "index_useres_on_reset_password_token", unique: true
  end

  add_foreign_key "tb_avaliacoes", "tb_empregados"
  add_foreign_key "tb_avaliacoes", "tb_empregados", column: "tb_empregado_gerente_id"
  add_foreign_key "tb_empregados", "tb_cargos"
  add_foreign_key "tb_respostas", "tb_avaliacoes"
  add_foreign_key "tb_respostas", "tb_perguntas"
  add_foreign_key "useres", "tb_empregados"
end
