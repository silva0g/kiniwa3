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

ActiveRecord::Schema.define(version: 20171204082148) do

  create_table "calendars", force: :cascade do |t|
    t.date     "day"
    t.integer  "price"
    t.integer  "status"
    t.integer  "menu_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["menu_id"], name: "index_calendars_on_menu_id"
  end

  create_table "conversations", force: :cascade do |t|
    t.integer  "sender_id"
    t.integer  "recepient_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "menus", force: :cascade do |t|
    t.string   "menu_type"
    t.string   "assiete_type"
    t.integer  "servings"
    t.string   "listing_name"
    t.text     "summary"
    t.string   "address"
    t.boolean  "is_salee"
    t.boolean  "is_sucree"
    t.boolean  "is_gluten"
    t.boolean  "is_epicee"
    t.integer  "price"
    t.boolean  "active"
    t.integer  "user_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "instant",      default: 1
    t.index ["user_id"], name: "index_menus_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text     "context"
    t.integer  "user_id"
    t.integer  "conversation_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["conversation_id"], name: "index_messages_on_conversation_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.string   "content"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "photos", force: :cascade do |t|
    t.integer  "menu_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.index ["imageable_type", "imageable_id"], name: "index_photos_on_imageable_type_and_imageable_id"
    t.index ["menu_id"], name: "index_photos_on_menu_id"
  end

  create_table "products", force: :cascade do |t|
    t.string   "listing_name"
    t.text     "summary"
    t.integer  "price"
    t.boolean  "active"
    t.string   "product_type"
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["user_id"], name: "index_products_on_user_id"
  end

  create_table "reservation_products", force: :cascade do |t|
    t.integer  "reservation_id"
    t.integer  "product_id"
    t.integer  "quantity"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["product_id"], name: "index_reservation_products_on_product_id"
    t.index ["reservation_id"], name: "index_reservation_products_on_reservation_id"
  end

  create_table "reservations", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "menu_id"
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer  "price"
    t.integer  "total"
    t.datetime "start_time"
    t.integer  "convive"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "status",     default: 0
    t.index ["menu_id"], name: "index_reservations_on_menu_id"
    t.index ["user_id"], name: "index_reservations_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.text     "comment"
    t.integer  "star",           default: 1
    t.integer  "menu_id"
    t.integer  "reservation_id"
    t.integer  "client_id"
    t.integer  "chef_id"
    t.string   "type"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["chef_id"], name: "index_reviews_on_chef_id"
    t.index ["client_id"], name: "index_reviews_on_client_id"
    t.index ["menu_id"], name: "index_reviews_on_menu_id"
    t.index ["reservation_id"], name: "index_reviews_on_reservation_id"
  end

  create_table "settings", force: :cascade do |t|
    t.boolean  "enable_sms",   default: true
    t.boolean  "enable_email", default: true
    t.integer  "user_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["user_id"], name: "index_settings_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "fullname"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "provider"
    t.string   "uid"
    t.string   "image"
    t.string   "phone_number"
    t.text     "description"
    t.string   "pin"
    t.boolean  "phone_verified"
    t.string   "stripe_id"
    t.string   "merchant_id"
    t.integer  "unread",                 default: 0
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
