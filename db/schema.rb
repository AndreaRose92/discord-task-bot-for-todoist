# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_06_06_184522) do
  create_table "projects", force: :cascade do |t|
    t.string "external_id"
    t.string "name"
    t.integer "comment_count"
    t.string "color"
    t.boolean "is_shared"
    t.integer "order"
    t.boolean "is_favorite"
    t.boolean "is_inbox_project"
    t.boolean "is_team_inbox"
    t.string "view_style"
    t.string "url"
    t.integer "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tasks", force: :cascade do |t|
    t.integer "project_id", null: false
    t.string "external_id"
    t.string "external_project_id"
    t.string "section_id"
    t.string "content"
    t.string "description"
    t.boolean "is_completed"
    t.string "labels"
    t.string "parent_id"
    t.integer "order"
    t.integer "priority"
    t.string "url"
    t.integer "comment_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_tasks_on_project_id"
  end

  add_foreign_key "tasks", "projects"
end
