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

ActiveRecord::Schema[8.0].define(version: 2025_05_04_074942) do
  create_table "tweeter_accounts", force: :cascade do |t|
    t.string "username"
    t.string "api_key"
    t.string "api_key_secret"
    t.string "access_token"
    t.string "access_token_secret"
    t.integer "newsletter_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["newsletter_id"], name: "index_tweeter_accounts_on_newsletter_id"
  end

  create_table "tweeter_threads", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "account_id"
    t.index ["account_id"], name: "index_tweeter_threads_on_account_id"
  end

  create_table "tweeter_tweets", force: :cascade do |t|
    t.text "content"
    t.datetime "published_at"
    t.integer "job_id", default: 0
    t.integer "account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "thread_id"
    t.index ["account_id"], name: "index_tweeter_tweets_on_account_id"
    t.index ["thread_id"], name: "index_tweeter_tweets_on_thread_id"
  end
end
