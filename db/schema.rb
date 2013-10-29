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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130705121208) do

  create_table "a", :id => false, :force => true do |t|
    t.integer "a"
  end

  create_table "ad_banners", :primary_key => "banner_id", :force => true do |t|
    t.integer  "banner_height", :null => false
    t.integer  "banner_width",  :null => false
    t.integer  "duration",      :null => false
    t.float    "banner_cost",   :null => false
    t.datetime "created_at",    :null => false
    t.datetime "updated_at"
  end

  add_index "ad_banners", ["banner_height", "banner_width", "duration", "banner_cost"], :name => "banner_height", :unique => true

  create_table "ad_list_details", :primary_key => "ad_list_details_id", :force => true do |t|
    t.integer  "vendor_id",                                     :null => false
    t.integer  "product_id",      :limit => 8,                  :null => false
    t.integer  "sub_category_id",                               :null => false
    t.text     "ad_text",                                       :null => false
    t.text     "ad_banner_image"
    t.text     "ad_external_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "active_flag",     :limit => 1, :default => "n"
  end

  add_index "ad_list_details", ["vendor_id", "ad_list_details_id"], :name => "vendor_id", :unique => true

  create_table "ad_list_details_counts", :force => true do |t|
    t.integer  "ad_list_details_id", :limit => 8, :null => false
    t.string   "displayed_page",                  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ad_lists", :primary_key => "ad_list_id", :force => true do |t|
    t.integer  "advertiser_id",   :null => false
    t.string   "ad_reference",    :null => false
    t.integer  "sub_category_id", :null => false
    t.integer  "banner_height",   :null => false
    t.integer  "banner_width",    :null => false
    t.integer  "duration",        :null => false
    t.date     "subscribed_date", :null => false
    t.datetime "created_at",      :null => false
    t.datetime "updated_at"
  end

  add_index "ad_lists", ["banner_height", "banner_width", "duration"], :name => "fk_ad_lists_ad_banners"

  create_table "advertisers_lists", :primary_key => "advertiser_id", :force => true do |t|
    t.string   "advertiser_name",                                            :null => false
    t.string   "advertiser_email",                                           :null => false
    t.string   "advertiser_phone",                                           :null => false
    t.string   "advertiser_fax",                           :default => "na"
    t.text     "advertiser_address",                                         :null => false
    t.string   "advertiser_sub_categories", :limit => 500,                   :null => false
    t.date     "subscribed_date",                                            :null => false
    t.integer  "advertiser_rating",                        :default => 0
    t.integer  "blocked_flag",                             :default => 0
    t.integer  "discarded_flag",                           :default => 0
    t.datetime "created_at",                                                 :null => false
    t.datetime "updated_at"
  end

  add_index "advertisers_lists", ["advertiser_name"], :name => "advertiser_name", :unique => true
  add_index "advertisers_lists", ["advertiser_phone"], :name => "advertiser_phone", :unique => true

  create_table "and_go_coupons", :primary_key => "and_go_coupon_id", :force => true do |t|
    t.string   "product_name",          :null => false
    t.float    "price",                 :null => false
    t.integer  "vendor_id",             :null => false
    t.string   "coupon_code",           :null => false
    t.string   "customer_phone_number", :null => false
    t.integer  "sub_category_id",       :null => false
    t.datetime "created_at",            :null => false
    t.datetime "updated_at"
  end

  add_index "and_go_coupons", ["vendor_id", "coupon_code"], :name => "vendor_id", :unique => true

  create_table "and_go_login_details", :primary_key => "and_go_id", :force => true do |t|
    t.string   "login_name",    :null => false
    t.string   "password_hash", :null => false
    t.string   "password_salt", :null => false
    t.datetime "created_at",    :null => false
    t.datetime "updated_at"
  end

  add_index "and_go_login_details", ["login_name"], :name => "login_name", :unique => true

  create_table "books_f1_authors", :primary_key => "author_id", :force => true do |t|
    t.string   "author_name", :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at"
  end

  add_index "books_f1_authors", ["author_name"], :name => "author_name", :unique => true

  create_table "books_f2_genres", :primary_key => "genre_id", :force => true do |t|
    t.string   "genre_name", :null => false
    t.integer  "level_id",   :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at"
  end

  add_index "books_f2_genres", ["genre_name", "level_id"], :name => "genre_name", :unique => true

  create_table "books_f3_isbns", :primary_key => "isbn_id", :force => true do |t|
    t.string   "isbn",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at"
  end

  add_index "books_f3_isbns", ["isbn"], :name => "isbn", :unique => true

  create_table "books_f4_isbn13s", :primary_key => "isbn13_id", :force => true do |t|
    t.string   "isbn13",     :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at"
  end

  add_index "books_f4_isbn13s", ["isbn13"], :name => "isbn13", :unique => true

  create_table "books_f5_bindings", :primary_key => "binding_id", :force => true do |t|
    t.string   "binding_name", :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at"
  end

  add_index "books_f5_bindings", ["binding_name"], :name => "binding_name", :unique => true

  create_table "books_f6_publishing_dates", :primary_key => "publishing_date_id", :force => true do |t|
    t.integer  "publishing_date", :null => false
    t.datetime "created_at",      :null => false
    t.datetime "updated_at"
  end

  add_index "books_f6_publishing_dates", ["publishing_date"], :name => "publishing_date", :unique => true

  create_table "books_f7_publishers", :primary_key => "publisher_id", :force => true do |t|
    t.string   "publisher",       :null => false
    t.string   "publisher_alias", :null => false
    t.datetime "created_at",      :null => false
    t.datetime "updated_at"
  end

  add_index "books_f7_publishers", ["publisher"], :name => "publisher", :unique => true

  create_table "books_f8_editions", :primary_key => "edition_id", :force => true do |t|
    t.string   "edition_name", :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at"
  end

  add_index "books_f8_editions", ["edition_name"], :name => "edition_name", :unique => true

  create_table "books_f9_languages", :primary_key => "language_id", :force => true do |t|
    t.string   "language_name", :null => false
    t.datetime "created_at",    :null => false
    t.datetime "updated_at"
  end

  add_index "books_f9_languages", ["language_name"], :name => "language_name", :unique => true

  create_table "books_lists", :primary_key => "books_list_id", :force => true do |t|
    t.string   "book_name",      :null => false
    t.text     "book_image_url"
    t.text     "book_features",  :null => false
    t.string   "isbn",           :null => false
    t.string   "isbn13",         :null => false
    t.datetime "created_at",     :null => false
    t.datetime "updated_at"
  end

  add_index "books_lists", ["isbn13"], :name => "isbn13", :unique => true

  create_table "books_reviews", :force => true do |t|
    t.string   "isbn",           :null => false
    t.string   "isbn13",         :null => false
    t.text     "description"
    t.float    "average_rating", :null => false
    t.text     "script"
    t.text     "miscellaneous"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at"
  end

  create_table "books_vendor_f10_availabilities", :primary_key => "availability_id", :force => true do |t|
    t.string   "availability", :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at"
  end

  add_index "books_vendor_f10_availabilities", ["availability"], :name => "availability", :unique => true

  create_table "branches", :primary_key => "branch_id", :force => true do |t|
    t.integer  "city_id",                                   :null => false
    t.string   "branch_name",                               :null => false
    t.string   "hub",         :limit => 1, :default => "n"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at"
  end

  add_index "branches", ["branch_name", "city_id"], :name => "branch_name", :unique => true

  create_table "brands", :force => true do |t|
    t.string   "name",       :null => false
    t.integer  "scid",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "checks", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "cities", :primary_key => "city_id", :force => true do |t|
    t.string   "city_name",  :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at"
  end

  add_index "cities", ["city_name"], :name => "city_name", :unique => true

  create_table "conversations", :primary_key => "conversation_id", :force => true do |t|
    t.string   "conversation", :limit => 60, :null => false
    t.integer  "validity",                   :null => false
    t.integer  "priority",                   :null => false
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at"
  end

  add_index "conversations", ["conversation", "validity", "priority"], :name => "conversation", :unique => true

  create_table "customer_care_entries", :force => true do |t|
    t.string   "customer_name",                  :null => false
    t.string   "customer_phone_no",              :null => false
    t.string   "customer_city",                  :null => false
    t.string   "customer_area",                  :null => false
    t.string   "customer_email",                 :null => false
    t.string   "enquiry_type",                   :null => false
    t.string   "category_enquired",              :null => false
    t.text     "product_enquired",               :null => false
    t.text     "shops_referred",                 :null => false
    t.string   "followup",          :limit => 1, :null => false
    t.string   "source",                         :null => false
    t.text     "misc",                           :null => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at"
  end

  add_index "customer_care_entries", ["customer_name", "customer_email"], :name => "cce_name_email", :unique => true
  add_index "customer_care_entries", ["customer_name", "customer_phone_no"], :name => "cce_name_phone", :unique => true

  create_table "customer_care_entries_comments", :primary_key => "customer_care_entries_comments_id", :force => true do |t|
    t.integer  "customer_care_entries_id", :limit => 8, :null => false
    t.string   "customer_phone_no",                     :null => false
    t.text     "comments",                              :null => false
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at"
  end

  create_table "desktops_f1_features", :primary_key => "feature_id", :force => true do |t|
    t.text     "feature_name", :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at"
  end

  create_table "desktops_lists", :primary_key => "desktops_list_id", :force => true do |t|
    t.string   "desktop_name",                                            :null => false
    t.string   "desktop_part_no",                                         :null => false
    t.text     "desktop_image_url"
    t.string   "desktop_brand",                                           :null => false
    t.string   "desktop_color",                                           :null => false
    t.text     "desktop_features",                                        :null => false
    t.string   "desktop_availability_flag", :limit => 1, :default => "y", :null => false
    t.datetime "created_at",                                              :null => false
    t.datetime "updated_at"
    t.text     "name_slug"
    t.text     "identifier_slug"
  end

  add_index "desktops_lists", ["desktop_name", "desktop_part_no"], :name => "name_id", :unique => true

  create_table "desktops_rates", :force => true do |t|
    t.integer  "desktops_list_id",         :limit => 8,                  :null => false
    t.text     "desktop_price_source_url",                               :null => false
    t.float    "dp_tamilnadu"
    t.float    "mrp",                                   :default => 0.0
    t.datetime "created_at",                                             :null => false
    t.datetime "updated_at"
  end

  create_table "desktops_vendor_f2_availabilities", :primary_key => "availability_id", :force => true do |t|
    t.string   "availability", :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at"
  end

  add_index "desktops_vendor_f2_availabilities", ["availability"], :name => "availability", :unique => true

  create_table "exclusive_coupons", :primary_key => "exclusive_coupon_id", :force => true do |t|
    t.integer  "exclusive_coupon_vendor_id", :null => false
    t.string   "exclusive_vendor_name",      :null => false
    t.string   "exclusive_coupon_code",      :null => false
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at"
  end

  add_index "exclusive_coupons", ["exclusive_coupon_vendor_id", "exclusive_coupon_code"], :name => "exclusive_coupon_vendor_id", :unique => true

  create_table "exclusive_coupons_vendor_details", :primary_key => "exclusive_coupon_vendor_id", :force => true do |t|
    t.string   "exclusive_vendor_name", :null => false
    t.datetime "created_at",            :null => false
    t.datetime "updated_at"
  end

  create_table "external_hdds_f1_features", :primary_key => "feature_id", :force => true do |t|
    t.text     "feature_name", :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at"
  end

  create_table "external_hdds_lists", :primary_key => "external_hdds_list_id", :force => true do |t|
    t.string   "external_hdd_name",                                            :null => false
    t.string   "external_hdd_part_no",                                         :null => false
    t.text     "external_hdd_image_url"
    t.string   "external_hdd_brand",                                           :null => false
    t.string   "external_hdd_color",                                           :null => false
    t.text     "external_hdd_features",                                        :null => false
    t.string   "external_hdd_availability_flag", :limit => 1, :default => "y", :null => false
    t.datetime "created_at",                                                   :null => false
    t.datetime "updated_at"
    t.text     "name_slug"
    t.text     "identifier_slug"
  end

  add_index "external_hdds_lists", ["external_hdd_name", "external_hdd_part_no"], :name => "name_id", :unique => true

  create_table "external_hdds_rates", :force => true do |t|
    t.integer  "external_hdds_list_id",         :limit => 8,                  :null => false
    t.text     "external_hdd_price_source_url",                               :null => false
    t.float    "dp_tamilnadu"
    t.float    "mrp",                                        :default => 0.0
    t.datetime "created_at",                                                  :null => false
    t.datetime "updated_at"
  end

  create_table "external_hdds_vendor_f2_availabilities", :primary_key => "availability_id", :force => true do |t|
    t.string   "availability", :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at"
  end

  add_index "external_hdds_vendor_f2_availabilities", ["availability"], :name => "availability", :unique => true

  create_table "features_master_values", :force => true do |t|
    t.string   "feature_name",                               :null => false
    t.string   "active_flag",  :limit => 1, :default => "n"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "filters_collections", :primary_key => "filters_collection_id", :force => true do |t|
    t.string   "filter_key",          :null => false
    t.integer  "filter_id",           :null => false
    t.string   "filter_table_name",   :null => false
    t.string   "filter_table_column", :null => false
    t.integer  "sub_category_id",     :null => false
    t.datetime "created_at",          :null => false
    t.datetime "updated_at"
  end

  add_index "filters_collections", ["filter_key", "filter_id", "filter_table_name", "filter_table_column"], :name => "filter_key", :unique => true

  create_table "fixed_pay_vendors", :force => true do |t|
    t.integer  "vendor_id",                      :null => false
    t.float    "accepted_amount",                :null => false
    t.integer  "period",                         :null => false
    t.date     "subscribed_date",                :null => false
    t.integer  "cut_off_period",                 :null => false
    t.integer  "history_flag",    :default => 0, :null => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at"
  end

  add_index "fixed_pay_vendors", ["vendor_id"], :name => "vendor_id", :unique => true

  create_table "fixed_pay_vendors_financials", :force => true do |t|
    t.integer  "vendor_id",                         :null => false
    t.float    "amount",                            :null => false
    t.integer  "period",                            :null => false
    t.date     "listing_start_date",                :null => false
    t.date     "listing_end_date",                  :null => false
    t.integer  "cut_off_period",                    :null => false
    t.integer  "history_flag",       :default => 0, :null => false
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at"
  end

  add_index "fixed_pay_vendors_financials", ["vendor_id"], :name => "vendor_id", :unique => true

  create_table "generic0051f39f3ef93ecfa012347477f1084e", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generic008f3b1e8d76b13687ff8042800c5008", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "generic01816953a725ea28e70c8dab50d796ee", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "generic02bcea06bb90b9fdf1fb2d1f558f7ffe", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generic0513d6a224ecd9d6c2188ae95bd944d7", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "generic065ad2e462e82afcb0c88644996a71ec", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "generic0685f110dff80e2758d5c10122303e46", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "generic08f96abc2e9c97075a19d9a522ffefb0", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "generic09c4ebef78a19f82dae2072f49a7c9ff", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generic0b19d2f64c06d6b6c48022713f940455", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "generic0c0858d5ceac9586240fd185ad885318", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "generic0d23183cb5a708d36aa7f29e04021dff", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "generic0ebf14c061bfbdc3ef1a8d7549f77822", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generic10dd944b5f5ef954411d965e9396f9d0", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "generic13725ab60ce6272605aa9b161a825554", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "generic13a24cdd02c8912c1c7e96460f42ee85", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generic15840d18a475e9d55797c910757bc1a4", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generic15bb76a5d17295771bd98794690cbd70", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generic15e4faece4ebc0db352e5ed0bbdf3fff", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generic16576f28356f05303eb45b3b94d40eb0", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generic16d1f0be7129181ba69dd4aa7048e60b", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generic170dd0d8b43fad1610cecf2d76062aaf", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "generic1742d6391b5f0442bc3655c41de422f5", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "generic17e61c076aaceb90130f329c90a46891", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "generic196032e2b23053667910c8affcbacb45", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generic1b5fbe14b474ef9c58b983fbc067aed7", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generic1b84717f2a6865736bfbbe39f9086710", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "generic1c5ed8da42a2d3a80cfe6d5e3baa05fa", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generic1f528757967c06cc6e79979d85110033", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generic21192a38433b4abd0ba05b78965efc90", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generic21f12b14f204e75d0f5f22ecd7bddcba", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generic22b5c74e3f8e948963dc41b9537c5838", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "generic2528c67793b2a3d00dc5310ed3d06b7f", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generic25dd463d76a967ba7ce7178922f13bf0", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "generic262333ad8b4100478c7a1c5475c96681", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generic26bb16c1b00288e5ef411e9f15bdd3dc", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "generic2a2f93a6896ecb7ba82d84f021aa0239", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "generic2a33328c3c2176e1708a5dc1d3ac6a01", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generic2ababfaeb030f5e9b0c41fe4603b23f8", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generic2ace910ffd1cf06ce86bb5d70b0b315a", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "generic2bd09cf5217ab0d4cb76c3cce251e250", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generic2c12b70d25554d2fde84b6b4f95dbc05", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generic2e29ee547a7fe241a967fb54a3c17c7d", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "generic2ec6a8bc165f131d01d62bb2dd49a9e7", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generic2efa759e3e566176b3d77e3ed47ec804", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "generic2f9d7b00af57ac098fb85b4befa95980", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "generic32152c255fb628d655cb556d8004d813", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "generic324404c2d254483d27999302881d1582", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generic3317ecc2e77b064a373c58d83aee5c80", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "generic33cabda21bf99d17e86ece179edcfe7f", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "generic362dccf6575cc2fd46d45b67f8cd05b2", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generic37f109c1b86ca7e2f50da250d335092b", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "generic38eeaf802b525ede073503b2660223cc", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generic391efc7fb6a857cb6b2c8de14f5a6d5b", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "generic39dd78881c388d114234605a0720966c", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generic3bd926102b758c7efc00636c18c4d8fc", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generic3d065440a3349cb6a03da37ae3fd1b05", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generic3d365427d0ccbb38e7b294349fad75bb", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "generic3d79d8505121244b0ae4b236a4825ebb", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "generic3dc4a8a00e9c624bb2d9c6a54c4e5116", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generic3f5747490b272ac6eef7ed0b4d17ee3d", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generic42a7a8e31368916781f30319e888f966", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "generic42dda356fba0e146d9930f140107d416", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generic432b59a290787e550550aad8906efc78", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "generic45e5f0a1d65ba1bace092d481535e7c3", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generic469c7a71886013980b3b5d3f10e0537e", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "generic46aed0ce2a38327264725e67aaf11458", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "generic470a4f8e9a909bd5e6a18fd1883dadfd", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generic47fd890407a6570b911340aac47699bd", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "generic485c70f59a1ae63332d3226677639a0f", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "generic4902b7f3822f0041c60c707421c9def5", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "generic497ce9f598028985c8daf6a6f3cb36be", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "generic4a982daaf5c874e1b4b9631d0ec71158", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generic4adf88db1ecf2a007919cfe792477804", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "generic4cf0b96f5e25be8332348f860f7c1cdd", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generic4cf1f29536b2df12cc7ca78dce80bd0c", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generic4e9414f4d8b0eea9cbc24d6016f437c6", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generic4f97db80e26bd172e1cd646103e4b8e5", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generic5044136995e5fe0011748425c9ef6e5a", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generic50d227c9457b861c0473bb2b234ab474", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "generic513bea064883b9e8e8043dfe56e53ffd", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generic5226dca69f70cb912dd63f0fe9869d90", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "generic52d15ebb8476694c6a9e67b2f4d77010", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "generic5314ec59a21eda81106d8e55a0fbd004", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "generic53686e43bfb277c290d050bfb23997bf", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generic53f61485d0228d786cb0fc004d136d37", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generic5427707f1668d26741c8286a1795ee76", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generic543600bada8e6afabc4d685c4c78a58e", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generic54497981a3afee2d7c7534b971ece3fe", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "generic54ce423233ab8c3c78ff4bc8f6d5f8b9", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "generic550fb66dcd65e6364973c1f447f3edec", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generic5553d06058dc5190bcec071946428859", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generic55843ac4f3164bcf6ab6ea0265bc0901", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "generic572506b810d2f4ab206b56922df5b2ad", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "generic5831caa9580669cdf03274ea32e03ca3", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generic58c75154c09197a050a5c6455e41bb17", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generic59b52621c041d3f751b72b549d453568", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generic5ad49080976890263075d55623bac8cd", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generic5bbd73ea8c56e1b8b9f6857fdd3bcacf", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "generic5c66be6681899193cd8dd839f88344e0", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "generic5db6eb2eb32162b475c29a2f9e19a616", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generic5de79ff04d7d01d21614d8d437672a5c", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "generic5e77e4af6a864564ae9cbae8a7661699", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "generic5ea26b7b5fc0b6201878b18396aeb5ac", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generic5eb1c3cd4250dfe020703d3ba1f86586", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "generic5ed4dd398abaa8b38f4151191fa2f923", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generic5f2b9559db0ac52b31481738f1028a9f", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generic5f43f72a427ad0afe071336b677c7a7e", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generic5fa0b4a43c43c35b6a41703ede16d0ec", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generic62a721ca1ed2c393221f0482bedce074", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "generic63822bec41d2b8263e0e5c27ea3b25c0", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generic66fbbf51c99b85adc98ae710c6ef36f6", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "generic677f2cc7551af04becd76f41e34deda6", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "generic67cdcc6080be28dbcc38c8d6f2ecfb9e", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generic67ee4b78915cde1023d0531fb09a99a0", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generic694c73807297e926a549dd7178fa3560", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generic6a6abee5f1d2b20024ffc070a192f45f", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generic6b41c6189888521cae33bc8c173b428e", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "generic6c800eeb3c8b275130aef2b257363cbe", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generic6cd0eb553f7bfcf7ab2815f6bca22c0b", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generic6cd8112ea06392dccd5d56ef1e196a61", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generic6e1b1bf01b9e18a3218b6aa8d151905d", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "generic6ed4a27fd4d882feb69cc0a0e78c1ab2", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generic70704520dfb2743c4e39da44329161a7", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "generic709926098f5f5753b64b4fd099f27cb2", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generic71aee8c0b24dbb56127277eb807eb9b1", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generic71c86abf69b791623b7544cb9f218e6e", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generic74602ba46cb9db2b43cdf43715dd1cb4", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generic746915cbdc756469eecc852247e91b0b", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "generic74e730129d57614b333e17d19de90b02", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "generic7500d5dfc03baa4788016c018f1082cd", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "generic752b4763b14851d9dfb219ffc95308c0", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generic756f3afb2e0fd86eb1cf6f55a32445c8", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generic762fca262c09d451a0cac950b5af976f", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generic77dbd467dd8fb664af015648d9fce4af", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "generic786513e6a41ce8566b49f54d1f9be0ea", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generic795d29e67f0e0555578d388e8342a3fe", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generic7a45ea5d20947569dce30000ac0f8a65", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "generic7abfb0f8a0087024ebd698279f8560b4", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generic7bb8737750c7c91209903610f27cae8b", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "generic7bf64adfbdb969c57d68f4eb78daab1a", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "generic7e7256873a613167493f616e5fabe961", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "generic7eae1c556e8a49bca3b24cd2509467d7", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generic7f65d84c2a7e24dc3c47462c25310011", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generic7fa587804e0b9d993a3098daf8f97d49", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generic800b76624924623f57ea7395850833ff", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generic81d6f94fe09702a3bf767b83f2430d90", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "generic821f34a017f9b05dba93364bb2dd6181", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "generic838131deeab6b6dc52b0d6561f476e39", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "generic861f59078ef8d37ac6aab0a3a70b20cf", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "generic86dbbb42aa68b6ba88a20ca379907840", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generic87041a12de73673a2b15f04c404370db", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "generic87e8bb445cc9e74e4a9ff0774eeacf09", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generic8a97d3d06a53559a611295b44470beb5", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "generic8a9ca8799663895ff9754be45e9418ed", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generic8d46861aa9bb902e1d6a50b29d04ca49", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "generic8e5e064d4f0ff86c717d0faeef5bbed9", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "generic90a5f0e4edf65f54ca7f80132cbde4cc", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "generic911ad7c3e9f8e1bb0298684d75b77247", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "generic916335cc71295ef64d765ac5088ec0b8", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generic9274db41ad7c7910fd416511f18e4c58", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generic931551c4f76f8ec00a88bb2144692222", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "generic94834690b2d783577b85c4ab3b258fa6", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "generic97b3793d13ebddc338ba2a1b49bd8543", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generic997e782ea3668faa85f930b9cca254d4", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generic9a2a5bd23c584a8a32342e261648c0da", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generic9a3e0343dc45f695ce4ce74fb8255d49", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generic9ae7895a0fa867b02ebc0dcf1ac36cc8", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generic9b4cb40c2ea04aefee07f50ea93104e1", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "generic9b52e49bd4a2571b3c8dc58a0531a5f1", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generic9d1c339e976b2e3dfbe48ced7091e6b1", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "generic9d5a200fb271893d8337ab2291e76f2e", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "generic9d5bc109d97313730ca019a7b1f93301", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "generic9dba511acdbf351e14813bfa9f2bd0b8", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "generica0404b3733d841a7305985c7f3dcf492", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generica05126d6c19f6dd144dcfdec18be84ed", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generica33cad4f8b1d228652f1126ad742107b", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generica36fa749e46dfc21fcdddb65c29dcfb5", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "generica58eddd71ce1141622993382c93775eb", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generica86bb992ccd72fa5dab68a4fd78b7cae", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generica9fe120f25fdcfe3a78b8faa27af4919", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "genericab73f1fb7099480d784f8a5145f50f67", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "genericabd961c3efe446032d11c6efc4143c8d", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "genericabe0b6a8674d497669a191ee94370279", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "genericac020da24318dfb50500997c419d05fd", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "genericac7b30c0d44f8a3bce56fed2142b5951", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "genericb0a8103bee4e8d4d3754003483b55e8c", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "genericb0ca0e3eda6417a2bdf95d58603512ea", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "genericb176036d7361bfacb494d19e164f2cbb", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "genericb1d3e8cf5dc76499a2163aad07ffaf55", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "genericb2ecf88b9e35aa3f8c66e12f176d8d48", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "genericb34504101dca93d1b8708e692a7a9586", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "genericb6468718f5eb354931a412dc2c8edf99", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "genericb6b1b9d44dff38f648e05f02df22e005", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "genericb7ccccd42ea7c4cb7efef35abd5ad7d9", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "genericb7ea78d5694dc2732f3747f93175ed36", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "genericb7f84ce562a7aa82fe3b31ba436a49c3", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "genericb81caafde8a4b3e7a1bbb59dbe0eaf5e", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "genericb87031b62dcc6557cbcd446d3b74f17c", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "genericb88f2d99ed74c712cf7a697e6fb5c430", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "genericb8ddc885fd378cd1885b27ffb745f2b4", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "genericb974752920011e1277faf3e3b9d64c6c", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "genericbb37f5303dc4f1b2e2849813fa80e859", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "genericbc3f7e618385c0a08210e6e666eff116", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "genericbcf4132551d683a0cc3ef03319e4e9c8", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "genericbecf4cc967054d84e9a95f812b8f50ed", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "genericbf8997ac6a728906e30c8e04bdc26d1f", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "genericbfccef01fac0ab1132da7459eeea366c", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "genericbfd1bb535d22e0806cf4783d8a2d8dbe", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "genericc12240e4dbeb37ef8fb6aa4b5814b029", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "genericc3d10812941cd77ca291117e69bbf8d1", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "genericc583f98619693a2312d9360aedc56933", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "genericc6a86f160766e0955eecf065904e3319", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "genericc776b5aa9e75491a951a3d9e8f1bc68e", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "genericc8f34924000e322ee03420dea6f60706", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "genericca26597c7debfbe296cf775976b0c1c6", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "genericca542d6dcb3655e31bc1e75f2a6492e0", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "genericcc51a9511ca0683bb2500fc2038703fe", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "genericcd044871ae5b9250ff40340bff369009", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "genericcd2885371eaea893cc30c962af40cedb", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "genericcfb0baf824a4f8def77292fb7a16ecac", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "genericd0adce40b7d90b198ddfee827efd0a00", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "genericd0ea94fffa5969d3b218b238d41e2484", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "genericd118674d885781ae9e34e9a5b0460bc5", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "genericd2214573a8f1aa7d1ceb27dfcaecda6d", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "genericd23a6c1b77d4db422a2f38a9a9acf2d5", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "genericd23d886cd1ac696618e13c66ed99725b", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "genericd282a4da2bf12963bfcb3144d91c833e", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "genericd2c8e2a6a8d4a51e28c2411fbca23609", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "genericd40eba88edcab650c11d1b89b836ef8d", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "genericd44b494d01a30bd34f4f51f2028a4ec2", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "genericd47b1ddc9f4529bc4950190656f515b2", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "genericd591dd17ad59c25fce672ab4cb1347ba", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "genericd8dcf7c941b66b84a82e7739656077fe", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "genericd8fa9e37ff851fe9b49928851c88dccc", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "genericd924e6db676462febff851d3cc357b28", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "genericd9c5ca363898a9633875e37ad9ebf79a", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "genericda09df767cc26fbd3ebaa3d94907e2d9", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "genericdbb07cd20e89589375106db197141b01", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "genericdbc5c1ecc717d11151aeef78921f920c", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "genericdc4e651e7108028e8b6effcf63e96112", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "genericded91ba42bf90dc2814e95b6b1bd9d33", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "genericdf287aa626cf7dd98177e93e5cc35ed7", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "genericdf6c1eb17bea39300963ecfbe2e7a68c", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generice107460e10706acd9d1254a818429a33", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generice1223bda61c1b53ce12bd980ef658563", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "generice1ddc72cd550273543e9992844e6ace4", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "generice3e747de7b82366b9ab3904724e5f192", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generice4a5350ed23874028394dc0950dbb6b0", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "generice5f13ede2e0ced706d22a5169f283cc3", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "generice61522d65cbc723329e9621c9da42027", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "generice93a239ff0c410dfc9787e0b5ffa3ccd", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "genericeb67c4d736009298e4d74b42e4d68462", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "genericed8d599a6ede6ae297595305dab51f95", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "genericedfd389572c8463de33d915ab9415203", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "genericee48127e46d329df997c5624c0938f01", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "genericee661bc4a48234e2c2b3af71b2fe0923", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "genericef4142d584b2a62bf045cceb55258d98", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "genericefe102fc5eff877e0a8852469c126e8e", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "genericf0fbec3dc1637c8dd71c268cb406339a", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "genericf112b7ff82b24c7e5a934dd66c0abe7b", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "genericf127911d0d512e0b2414a96a76d7bbd0", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "genericf3274ae9b72852a5b765d5e11ebe79f4", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "genericf513492b94c6feb97ee3a4fa64199a25", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "genericf5ab908835a5834de1978edb887e5a7c", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "genericf64d2c19bea00b828ad654327a96823e", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "genericf83265abd4b1c1581aeed2927b4220e0", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "genericfa47f88173cb0852e73bf1864a20f006", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "genericfa5402eb0b52cad4dbf405b51059ae8b", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "genericfa69cad8a253838444667b42fc25b2c6", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "genericfc16a072514a28dae95f4f4aed0d0997", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "genericfd4718b62250815e6d55431153179c96", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "genericfe535c025be72cfb7e90d9633c12a44e", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "genericfeaef95383026d071bd548ac85c5fdab", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :default => 0, :null => false
    t.integer "sub_category_id",               :default => 0, :null => false
  end

  create_table "genericfee2f6c7d457f87c70f8550bc126ff73", :id => false, :force => true do |t|
    t.integer "products_list_id", :limit => 8, :null => false
    t.integer "sub_category_id",               :null => false
  end

  create_table "gifts", :primary_key => "gift_id", :force => true do |t|
    t.string   "gift_name"
    t.text     "gift_image_url"
    t.text     "gift_external_url"
    t.text     "gift_description"
    t.string   "active_flag",       :limit => 1, :default => "n"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "gifts_customer_informations", :force => true do |t|
    t.integer  "gift_id",               :null => false
    t.string   "gift_name",             :null => false
    t.string   "coupon_code",           :null => false
    t.string   "customer_name",         :null => false
    t.text     "customer_address",      :null => false
    t.string   "customer_phone_number", :null => false
    t.text     "invoice_number",        :null => false
    t.text     "vendor_name"
    t.string   "vendor_branch_name"
    t.string   "vendor_city_name"
    t.string   "vendor_phone_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "headphones_f1_features", :primary_key => "feature_id", :force => true do |t|
    t.text     "feature_name", :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at"
  end

  create_table "headphones_lists", :primary_key => "headphones_list_id", :force => true do |t|
    t.string   "headphone_name",                                            :null => false
    t.string   "headphone_part_no",                                         :null => false
    t.text     "headphone_image_url"
    t.string   "headphone_brand",                                           :null => false
    t.string   "headphone_type",                                            :null => false
    t.text     "headphone_features",                                        :null => false
    t.string   "headphone_availability_flag", :limit => 1, :default => "y", :null => false
    t.datetime "created_at",                                                :null => false
    t.datetime "updated_at"
    t.text     "name_slug"
    t.text     "identifier_slug"
  end

  add_index "headphones_lists", ["headphone_name", "headphone_part_no"], :name => "name_id", :unique => true

  create_table "headphones_rates", :force => true do |t|
    t.integer  "headphones_list_id",         :limit => 8,                  :null => false
    t.text     "headphone_price_source_url",                               :null => false
    t.float    "dp_tamilnadu"
    t.float    "mrp",                                     :default => 0.0
    t.datetime "created_at",                                               :null => false
    t.datetime "updated_at"
  end

  create_table "headphones_vendor_f2_availabilities", :primary_key => "availability_id", :force => true do |t|
    t.string   "availability", :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at"
  end

  add_index "headphones_vendor_f2_availabilities", ["availability"], :name => "availability", :unique => true

  create_table "headsets_f1_features", :primary_key => "feature_id", :force => true do |t|
    t.text     "feature_name", :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at"
  end

  create_table "headsets_lists", :primary_key => "headsets_list_id", :force => true do |t|
    t.string   "headset_name",                                            :null => false
    t.string   "headset_part_no",                                         :null => false
    t.text     "headset_image_url"
    t.string   "headset_brand",                                           :null => false
    t.string   "headset_type",                                            :null => false
    t.text     "headset_features",                                        :null => false
    t.string   "headset_availability_flag", :limit => 1, :default => "y", :null => false
    t.datetime "created_at",                                              :null => false
    t.datetime "updated_at"
    t.text     "name_slug"
    t.text     "identifier_slug"
  end

  add_index "headsets_lists", ["headset_name", "headset_part_no"], :name => "name_id", :unique => true

  create_table "headsets_rates", :force => true do |t|
    t.integer  "headsets_list_id",         :limit => 8,                  :null => false
    t.text     "headset_price_source_url",                               :null => false
    t.float    "dp_tamilnadu"
    t.float    "mrp",                                   :default => 0.0
    t.datetime "created_at",                                             :null => false
    t.datetime "updated_at"
  end

  create_table "headsets_vendor_f2_availabilities", :primary_key => "availability_id", :force => true do |t|
    t.string   "availability", :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at"
  end

  add_index "headsets_vendor_f2_availabilities", ["availability"], :name => "availability", :unique => true

  create_table "jumps", :force => true do |t|
    t.string   "cat"
    t.datetime "t"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "keyboards_f1_features", :primary_key => "feature_id", :force => true do |t|
    t.text     "feature_name", :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at"
  end

  create_table "keyboards_lists", :primary_key => "keyboards_list_id", :force => true do |t|
    t.string   "keyboard_name",                                            :null => false
    t.string   "keyboard_part_no",                                         :null => false
    t.text     "keyboard_image_url"
    t.string   "keyboard_brand",                                           :null => false
    t.string   "keyboard_interface",                                       :null => false
    t.text     "keyboard_features",                                        :null => false
    t.string   "keyboard_availability_flag", :limit => 1, :default => "y", :null => false
    t.datetime "created_at",                                               :null => false
    t.datetime "updated_at"
    t.text     "name_slug"
    t.text     "identifier_slug"
  end

  add_index "keyboards_lists", ["keyboard_name", "keyboard_part_no"], :name => "name_id", :unique => true

  create_table "keyboards_rates", :force => true do |t|
    t.integer  "keyboards_list_id",         :limit => 8,                  :null => false
    t.text     "keyboard_price_source_url",                               :null => false
    t.float    "dp_tamilnadu"
    t.float    "mrp",                                    :default => 0.0
    t.datetime "created_at",                                              :null => false
    t.datetime "updated_at"
  end

  create_table "keyboards_vendor_f2_availabilities", :primary_key => "availability_id", :force => true do |t|
    t.string   "availability", :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at"
  end

  add_index "keyboards_vendor_f2_availabilities", ["availability"], :name => "availability", :unique => true

  create_table "laptops_f1_features", :primary_key => "feature_id", :force => true do |t|
    t.text     "feature_name", :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at"
  end

  create_table "laptops_lists", :primary_key => "laptops_list_id", :force => true do |t|
    t.string   "laptop_name",                                            :null => false
    t.string   "laptop_part_no",                                         :null => false
    t.text     "laptop_image_url"
    t.string   "laptop_brand",                                           :null => false
    t.string   "laptop_color",                                           :null => false
    t.text     "laptop_features",                                        :null => false
    t.string   "laptop_availability_flag", :limit => 1, :default => "y", :null => false
    t.datetime "created_at",                                             :null => false
    t.datetime "updated_at"
    t.text     "name_slug"
    t.text     "identifier_slug"
  end

  add_index "laptops_lists", ["laptop_name", "laptop_part_no"], :name => "name_id", :unique => true

  create_table "laptops_rates", :force => true do |t|
    t.integer  "laptops_list_id",         :limit => 8,                  :null => false
    t.text     "laptop_price_source_url",                               :null => false
    t.float    "dp_tamilnadu"
    t.float    "mrp",                                  :default => 0.0
    t.datetime "created_at",                                            :null => false
    t.datetime "updated_at"
  end

  create_table "laptops_vendor_f2_availabilities", :primary_key => "availability_id", :force => true do |t|
    t.string   "availability", :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at"
  end

  add_index "laptops_vendor_f2_availabilities", ["availability"], :name => "availability", :unique => true

  create_table "link_advertisers_lists_sub_categories", :primary_key => "link_id", :force => true do |t|
    t.integer  "advertiser_id",   :null => false
    t.integer  "sub_category_id", :null => false
    t.datetime "created_at",      :null => false
    t.datetime "updated_at"
  end

  add_index "link_advertisers_lists_sub_categories", ["advertiser_id", "sub_category_id"], :name => "advertiser_id", :unique => true
  add_index "link_advertisers_lists_sub_categories", ["sub_category_id"], :name => "fk_link_advertisers_lists_sub_categories"

  create_table "link_books_lists_reviews", :force => true do |t|
    t.integer  "books_list_id",    :limit => 8, :null => false
    t.integer  "books_reviews_id",              :null => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at"
  end

  add_index "link_books_lists_reviews", ["books_list_id"], :name => "books_list_id"
  add_index "link_books_lists_reviews", ["books_reviews_id"], :name => "books_reviews_id"

  create_table "link_f10_mobiles_lists", :force => true do |t|
    t.integer  "mobiles_list_id",     :limit => 8, :null => false
    t.integer  "secondary_camera_id",              :null => false
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at"
  end

  add_index "link_f10_mobiles_lists", ["mobiles_list_id", "secondary_camera_id"], :name => "mobiles_list_id", :unique => true
  add_index "link_f10_mobiles_lists", ["secondary_camera_id"], :name => "fk1_links_secondary_cameras"

  create_table "link_f10_vendor_books_lists", :force => true do |t|
    t.integer  "vendor_id",                    :null => false
    t.integer  "books_list_id",   :limit => 8, :null => false
    t.integer  "availability_id",              :null => false
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at"
  end

  add_index "link_f10_vendor_books_lists", ["availability_id"], :name => "fk_link_f10_vendor_books_lists_availability"
  add_index "link_f10_vendor_books_lists", ["books_list_id"], :name => "fk_link_f10_vendor_books_lists"
  add_index "link_f10_vendor_books_lists", ["vendor_id", "books_list_id"], :name => "vendor_id", :unique => true

  create_table "link_f11_mobiles_lists", :force => true do |t|
    t.integer  "mobiles_list_id", :limit => 8, :null => false
    t.integer  "processor_id",                 :null => false
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at"
  end

  add_index "link_f11_mobiles_lists", ["mobiles_list_id", "processor_id"], :name => "mobiles_list_id", :unique => true
  add_index "link_f11_mobiles_lists", ["processor_id"], :name => "fk1_links_processors"

  create_table "link_f12_mobiles_lists", :force => true do |t|
    t.integer  "mobiles_list_id", :limit => 8, :null => false
    t.integer  "messaging_id",                 :null => false
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at"
  end

  add_index "link_f12_mobiles_lists", ["messaging_id"], :name => "fk1_links_messagings"
  add_index "link_f12_mobiles_lists", ["mobiles_list_id", "messaging_id"], :name => "mobiles_list_id", :unique => true

  create_table "link_f13_mobiles_lists", :force => true do |t|
    t.integer  "mobiles_list_id", :limit => 8, :null => false
    t.integer  "browser_id",                   :null => false
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at"
  end

  add_index "link_f13_mobiles_lists", ["browser_id"], :name => "fk1_links_browsers"
  add_index "link_f13_mobiles_lists", ["mobiles_list_id", "browser_id"], :name => "mobiles_list_id", :unique => true

  create_table "link_f14_mobiles_lists", :force => true do |t|
    t.integer  "mobiles_list_id", :limit => 8, :null => false
    t.integer  "mobile_ram_id",                :null => false
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at"
  end

  add_index "link_f14_mobiles_lists", ["mobile_ram_id"], :name => "fk1_links_mobile_rams"
  add_index "link_f14_mobiles_lists", ["mobiles_list_id", "mobile_ram_id"], :name => "mobiles_list_id", :unique => true

  create_table "link_f15_mobiles_lists", :force => true do |t|
    t.integer  "mobiles_list_id", :limit => 8, :null => false
    t.integer  "assorteds_id",                 :null => false
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at"
  end

  add_index "link_f15_mobiles_lists", ["assorteds_id"], :name => "fk1_links_assorteds"
  add_index "link_f15_mobiles_lists", ["mobiles_list_id", "assorteds_id"], :name => "mobiles_list_id", :unique => true

  create_table "link_f16_vendor_mobiles_lists", :force => true do |t|
    t.integer  "vendor_id",                    :null => false
    t.integer  "mobiles_list_id", :limit => 8, :null => false
    t.integer  "availability_id",              :null => false
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at"
  end

  add_index "link_f16_vendor_mobiles_lists", ["availability_id"], :name => "fk1_links_availabilities"
  add_index "link_f16_vendor_mobiles_lists", ["mobiles_list_id"], :name => "fk1_links_mobiles_16"
  add_index "link_f16_vendor_mobiles_lists", ["vendor_id", "mobiles_list_id"], :name => "vendor_id", :unique => true

  create_table "link_f1_books_lists", :force => true do |t|
    t.integer  "books_list_id", :limit => 8, :null => false
    t.integer  "author_id",                  :null => false
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at"
  end

  add_index "link_f1_books_lists", ["author_id"], :name => "fk_links_authors"
  add_index "link_f1_books_lists", ["books_list_id", "author_id"], :name => "books_list_id", :unique => true

  create_table "link_f1_desktops_lists", :force => true do |t|
    t.integer  "desktops_list_id", :limit => 8, :null => false
    t.integer  "feature_id",       :limit => 8, :null => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at"
  end

  add_index "link_f1_desktops_lists", ["desktops_list_id", "feature_id"], :name => "desktops_list_id", :unique => true
  add_index "link_f1_desktops_lists", ["feature_id"], :name => "fk_links_desktops_features"

  create_table "link_f1_external_hdds_lists", :force => true do |t|
    t.integer  "external_hdds_list_id", :limit => 8, :null => false
    t.integer  "feature_id",            :limit => 8, :null => false
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at"
  end

  add_index "link_f1_external_hdds_lists", ["external_hdds_list_id", "feature_id"], :name => "external_hdds_list_id", :unique => true
  add_index "link_f1_external_hdds_lists", ["feature_id"], :name => "fk_links_external_hdds_features"

  create_table "link_f1_headphones_lists", :force => true do |t|
    t.integer  "headphones_list_id", :limit => 8, :null => false
    t.integer  "feature_id",         :limit => 8, :null => false
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at"
  end

  add_index "link_f1_headphones_lists", ["feature_id"], :name => "fk_links_headphones_features"
  add_index "link_f1_headphones_lists", ["headphones_list_id", "feature_id"], :name => "headphones_list_id", :unique => true

  create_table "link_f1_headsets_lists", :force => true do |t|
    t.integer  "headsets_list_id", :limit => 8, :null => false
    t.integer  "feature_id",       :limit => 8, :null => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at"
  end

  add_index "link_f1_headsets_lists", ["feature_id"], :name => "fk_links_headsets_features"
  add_index "link_f1_headsets_lists", ["headsets_list_id", "feature_id"], :name => "headsets_list_id", :unique => true

  create_table "link_f1_keyboards_lists", :force => true do |t|
    t.integer  "keyboards_list_id", :limit => 8, :null => false
    t.integer  "feature_id",        :limit => 8, :null => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at"
  end

  add_index "link_f1_keyboards_lists", ["feature_id"], :name => "fk_links_keyboards_features"
  add_index "link_f1_keyboards_lists", ["keyboards_list_id", "feature_id"], :name => "keyboards_list_id", :unique => true

  create_table "link_f1_laptops_lists", :force => true do |t|
    t.integer  "laptops_list_id", :limit => 8, :null => false
    t.integer  "feature_id",      :limit => 8, :null => false
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at"
  end

  add_index "link_f1_laptops_lists", ["feature_id"], :name => "fk_links_features"
  add_index "link_f1_laptops_lists", ["laptops_list_id", "feature_id"], :name => "laptops_list_id", :unique => true

  create_table "link_f1_memory_cards_lists", :force => true do |t|
    t.integer  "memory_cards_list_id", :limit => 8, :null => false
    t.integer  "feature_id",           :limit => 8, :null => false
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at"
  end

  add_index "link_f1_memory_cards_lists", ["feature_id"], :name => "fk_links_memory_cards_features"
  add_index "link_f1_memory_cards_lists", ["memory_cards_list_id", "feature_id"], :name => "memory_cards_list_id", :unique => true

  create_table "link_f1_mobiles_lists", :force => true do |t|
    t.integer  "mobiles_list_id", :limit => 8, :null => false
    t.integer  "mobile_brand_id",              :null => false
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at"
  end

  add_index "link_f1_mobiles_lists", ["mobile_brand_id"], :name => "fk1_links_mobile_brands"
  add_index "link_f1_mobiles_lists", ["mobiles_list_id", "mobile_brand_id"], :name => "mobiles_list_id", :unique => true

  create_table "link_f1_mouses_lists", :force => true do |t|
    t.integer  "mouses_list_id", :limit => 8, :null => false
    t.integer  "feature_id",     :limit => 8, :null => false
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at"
  end

  add_index "link_f1_mouses_lists", ["feature_id"], :name => "fk_links_mouses_features"
  add_index "link_f1_mouses_lists", ["mouses_list_id", "feature_id"], :name => "mouses_list_id", :unique => true

  create_table "link_f1_pendrives_lists", :force => true do |t|
    t.integer  "pendrives_list_id", :limit => 8, :null => false
    t.integer  "feature_id",        :limit => 8, :null => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at"
  end

  add_index "link_f1_pendrives_lists", ["feature_id"], :name => "fk_links_pendrives_features"
  add_index "link_f1_pendrives_lists", ["pendrives_list_id", "feature_id"], :name => "pendrives_list_id", :unique => true

  create_table "link_f1_printers_lists", :force => true do |t|
    t.integer  "printers_list_id", :limit => 8, :null => false
    t.integer  "feature_id",       :limit => 8, :null => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at"
  end

  add_index "link_f1_printers_lists", ["feature_id"], :name => "fk_links_printers_features"
  add_index "link_f1_printers_lists", ["printers_list_id", "feature_id"], :name => "printers_list_id", :unique => true

  create_table "link_f1_routers_lists", :force => true do |t|
    t.integer  "routers_list_id", :limit => 8, :null => false
    t.integer  "feature_id",      :limit => 8, :null => false
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at"
  end

  add_index "link_f1_routers_lists", ["feature_id"], :name => "fk_links_routers_features"
  add_index "link_f1_routers_lists", ["routers_list_id", "feature_id"], :name => "routers_list_id", :unique => true

  create_table "link_f1_speakers_lists", :force => true do |t|
    t.integer  "speakers_list_id", :limit => 8, :null => false
    t.integer  "feature_id",       :limit => 8, :null => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at"
  end

  add_index "link_f1_speakers_lists", ["feature_id"], :name => "fk_links_speakers_features"
  add_index "link_f1_speakers_lists", ["speakers_list_id", "feature_id"], :name => "speakers_list_id", :unique => true

  create_table "link_f1_tablets_lists", :force => true do |t|
    t.integer  "tablets_list_id", :limit => 8, :null => false
    t.integer  "feature_id",      :limit => 8, :null => false
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at"
  end

  add_index "link_f1_tablets_lists", ["feature_id"], :name => "fk_links_tablets_features"
  add_index "link_f1_tablets_lists", ["tablets_list_id", "feature_id"], :name => "tablets_list_id", :unique => true

  create_table "link_f2_books_lists", :force => true do |t|
    t.integer  "books_list_id", :limit => 8, :null => false
    t.integer  "genre_id",                   :null => false
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at"
  end

  add_index "link_f2_books_lists", ["books_list_id", "genre_id"], :name => "books_list_id", :unique => true
  add_index "link_f2_books_lists", ["genre_id"], :name => "fk_links_genres"

  create_table "link_f2_mobiles_lists", :force => true do |t|
    t.integer  "mobiles_list_id", :limit => 8, :null => false
    t.integer  "mobile_color_id",              :null => false
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at"
  end

  add_index "link_f2_mobiles_lists", ["mobile_color_id"], :name => "fk1_links_mobile_colors"
  add_index "link_f2_mobiles_lists", ["mobiles_list_id", "mobile_color_id"], :name => "mobiles_list_id", :unique => true

  create_table "link_f2_vendor_desktops_lists", :force => true do |t|
    t.integer  "vendor_id",                     :null => false
    t.integer  "desktops_list_id", :limit => 8, :null => false
    t.integer  "availability_id",               :null => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at"
  end

  add_index "link_f2_vendor_desktops_lists", ["availability_id"], :name => "fk_link_f2_vendor_desktops_lists_availability"
  add_index "link_f2_vendor_desktops_lists", ["desktops_list_id"], :name => "fk_link_f2_vendor_desktops_lists"
  add_index "link_f2_vendor_desktops_lists", ["vendor_id", "desktops_list_id"], :name => "vendor_id", :unique => true

  create_table "link_f2_vendor_external_hdds_lists", :force => true do |t|
    t.integer  "vendor_id",                          :null => false
    t.integer  "external_hdds_list_id", :limit => 8, :null => false
    t.integer  "availability_id",                    :null => false
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at"
  end

  add_index "link_f2_vendor_external_hdds_lists", ["availability_id"], :name => "fk_link_f2_vendor_external_hdds_lists_availability"
  add_index "link_f2_vendor_external_hdds_lists", ["external_hdds_list_id"], :name => "fk_link_f2_vendor_external_hdds_lists"
  add_index "link_f2_vendor_external_hdds_lists", ["vendor_id", "external_hdds_list_id"], :name => "vendor_id", :unique => true

  create_table "link_f2_vendor_headphones_lists", :force => true do |t|
    t.integer  "vendor_id",                       :null => false
    t.integer  "headphones_list_id", :limit => 8, :null => false
    t.integer  "availability_id",                 :null => false
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at"
  end

  add_index "link_f2_vendor_headphones_lists", ["availability_id"], :name => "fk_link_f2_vendor_headphones_lists_availability"
  add_index "link_f2_vendor_headphones_lists", ["headphones_list_id"], :name => "fk_link_f2_vendor_headphones_lists"
  add_index "link_f2_vendor_headphones_lists", ["vendor_id", "headphones_list_id"], :name => "vendor_id", :unique => true

  create_table "link_f2_vendor_headsets_lists", :force => true do |t|
    t.integer  "vendor_id",                     :null => false
    t.integer  "headsets_list_id", :limit => 8, :null => false
    t.integer  "availability_id",               :null => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at"
  end

  add_index "link_f2_vendor_headsets_lists", ["availability_id"], :name => "fk_link_f2_vendor_headsets_lists_availability"
  add_index "link_f2_vendor_headsets_lists", ["headsets_list_id"], :name => "fk_link_f2_vendor_headsets_lists"
  add_index "link_f2_vendor_headsets_lists", ["vendor_id", "headsets_list_id"], :name => "vendor_id", :unique => true

  create_table "link_f2_vendor_keyboards_lists", :force => true do |t|
    t.integer  "vendor_id",                      :null => false
    t.integer  "keyboards_list_id", :limit => 8, :null => false
    t.integer  "availability_id",                :null => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at"
  end

  add_index "link_f2_vendor_keyboards_lists", ["availability_id"], :name => "fk_link_f2_vendor_keyboards_lists_availability"
  add_index "link_f2_vendor_keyboards_lists", ["keyboards_list_id"], :name => "fk_link_f2_vendor_keyboards_lists"
  add_index "link_f2_vendor_keyboards_lists", ["vendor_id", "keyboards_list_id"], :name => "vendor_id", :unique => true

  create_table "link_f2_vendor_laptops_lists", :force => true do |t|
    t.integer  "vendor_id",                    :null => false
    t.integer  "laptops_list_id", :limit => 8, :null => false
    t.integer  "availability_id",              :null => false
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at"
  end

  add_index "link_f2_vendor_laptops_lists", ["availability_id"], :name => "fk_link_f2_vendor_laptops_lists_availability"
  add_index "link_f2_vendor_laptops_lists", ["laptops_list_id"], :name => "fk_link_f2_vendor_laptops_lists"
  add_index "link_f2_vendor_laptops_lists", ["vendor_id", "laptops_list_id"], :name => "vendor_id", :unique => true

  create_table "link_f2_vendor_memory_cards_lists", :force => true do |t|
    t.integer  "vendor_id",                         :null => false
    t.integer  "memory_cards_list_id", :limit => 8, :null => false
    t.integer  "availability_id",                   :null => false
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at"
  end

  add_index "link_f2_vendor_memory_cards_lists", ["availability_id"], :name => "fk_link_f2_vendor_memory_cards_lists_availability"
  add_index "link_f2_vendor_memory_cards_lists", ["memory_cards_list_id"], :name => "fk_link_f2_vendor_memory_cards_lists"
  add_index "link_f2_vendor_memory_cards_lists", ["vendor_id", "memory_cards_list_id"], :name => "vendor_id", :unique => true

  create_table "link_f2_vendor_mouses_lists", :force => true do |t|
    t.integer  "vendor_id",                    :null => false
    t.integer  "mouses_list_id",  :limit => 8, :null => false
    t.integer  "availability_id",              :null => false
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at"
  end

  add_index "link_f2_vendor_mouses_lists", ["availability_id"], :name => "fk_link_f2_vendor_mouses_lists_availability"
  add_index "link_f2_vendor_mouses_lists", ["mouses_list_id"], :name => "fk_link_f2_vendor_mouses_lists"
  add_index "link_f2_vendor_mouses_lists", ["vendor_id", "mouses_list_id"], :name => "vendor_id", :unique => true

  create_table "link_f2_vendor_pendrives_lists", :force => true do |t|
    t.integer  "vendor_id",                      :null => false
    t.integer  "pendrives_list_id", :limit => 8, :null => false
    t.integer  "availability_id",                :null => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at"
  end

  add_index "link_f2_vendor_pendrives_lists", ["availability_id"], :name => "fk_link_f2_vendor_pendrives_lists_availability"
  add_index "link_f2_vendor_pendrives_lists", ["pendrives_list_id"], :name => "fk_link_f2_vendor_pendrives_lists"
  add_index "link_f2_vendor_pendrives_lists", ["vendor_id", "pendrives_list_id"], :name => "vendor_id", :unique => true

  create_table "link_f2_vendor_printers_lists", :force => true do |t|
    t.integer  "vendor_id",                     :null => false
    t.integer  "printers_list_id", :limit => 8, :null => false
    t.integer  "availability_id",               :null => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at"
  end

  add_index "link_f2_vendor_printers_lists", ["availability_id"], :name => "fk_link_f2_vendor_printers_lists_availability"
  add_index "link_f2_vendor_printers_lists", ["printers_list_id"], :name => "fk_link_f2_vendor_printers_lists"
  add_index "link_f2_vendor_printers_lists", ["vendor_id", "printers_list_id"], :name => "vendor_id", :unique => true

  create_table "link_f2_vendor_routers_lists", :force => true do |t|
    t.integer  "vendor_id",                    :null => false
    t.integer  "routers_list_id", :limit => 8, :null => false
    t.integer  "availability_id",              :null => false
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at"
  end

  add_index "link_f2_vendor_routers_lists", ["availability_id"], :name => "fk_link_f2_vendor_routers_lists_availability"
  add_index "link_f2_vendor_routers_lists", ["routers_list_id"], :name => "fk_link_f2_vendor_routers_lists"
  add_index "link_f2_vendor_routers_lists", ["vendor_id", "routers_list_id"], :name => "vendor_id", :unique => true

  create_table "link_f2_vendor_speakers_lists", :force => true do |t|
    t.integer  "vendor_id",                     :null => false
    t.integer  "speakers_list_id", :limit => 8, :null => false
    t.integer  "availability_id",               :null => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at"
  end

  add_index "link_f2_vendor_speakers_lists", ["availability_id"], :name => "fk_link_f2_vendor_speakers_lists_availability"
  add_index "link_f2_vendor_speakers_lists", ["speakers_list_id"], :name => "fk_link_f2_vendor_speakers_lists"
  add_index "link_f2_vendor_speakers_lists", ["vendor_id", "speakers_list_id"], :name => "vendor_id", :unique => true

  create_table "link_f2_vendor_tablets_lists", :force => true do |t|
    t.integer  "vendor_id",                    :null => false
    t.integer  "tablets_list_id", :limit => 8, :null => false
    t.integer  "availability_id",              :null => false
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at"
  end

  add_index "link_f2_vendor_tablets_lists", ["availability_id"], :name => "fk_link_f2_vendor_tablets_lists_availability"
  add_index "link_f2_vendor_tablets_lists", ["tablets_list_id"], :name => "fk_link_f2_vendor_tablets_lists"
  add_index "link_f2_vendor_tablets_lists", ["vendor_id", "tablets_list_id"], :name => "vendor_id", :unique => true

  create_table "link_f3_books_lists", :force => true do |t|
    t.integer  "books_list_id", :limit => 8, :null => false
    t.integer  "isbn_id",                    :null => false
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at"
  end

  add_index "link_f3_books_lists", ["books_list_id", "isbn_id"], :name => "books_list_id", :unique => true
  add_index "link_f3_books_lists", ["isbn_id"], :name => "fk_links_isbns"

  create_table "link_f3_mobiles_lists", :force => true do |t|
    t.integer  "mobiles_list_id", :limit => 8, :null => false
    t.integer  "mobile_type_id",               :null => false
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at"
  end

  add_index "link_f3_mobiles_lists", ["mobile_type_id"], :name => "fk1_links_mobile_types"
  add_index "link_f3_mobiles_lists", ["mobiles_list_id", "mobile_type_id"], :name => "mobiles_list_id", :unique => true

  create_table "link_f4_books_lists", :force => true do |t|
    t.integer  "books_list_id", :limit => 8, :null => false
    t.integer  "isbn13_id",                  :null => false
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at"
  end

  add_index "link_f4_books_lists", ["books_list_id", "isbn13_id"], :name => "books_list_id", :unique => true
  add_index "link_f4_books_lists", ["isbn13_id"], :name => "fk_links_isbn13s"

  create_table "link_f4_mobiles_lists", :force => true do |t|
    t.integer  "mobiles_list_id",  :limit => 8, :null => false
    t.integer  "mobile_design_id",              :null => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at"
  end

  add_index "link_f4_mobiles_lists", ["mobile_design_id"], :name => "fk1_links_mobile_designs"
  add_index "link_f4_mobiles_lists", ["mobiles_list_id", "mobile_design_id"], :name => "mobiles_list_id", :unique => true

  create_table "link_f5_books_lists", :force => true do |t|
    t.integer  "books_list_id", :limit => 8, :null => false
    t.integer  "binding_id",                 :null => false
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at"
  end

  add_index "link_f5_books_lists", ["binding_id"], :name => "fk_links_bindings"
  add_index "link_f5_books_lists", ["books_list_id", "binding_id"], :name => "books_list_id", :unique => true

  create_table "link_f5_c_mobiles_lists", :force => true do |t|
    t.integer  "mobiles_list_id",           :limit => 8, :null => false
    t.integer  "mobile_os_version_name_id",              :null => false
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at"
  end

  add_index "link_f5_c_mobiles_lists", ["mobiles_list_id", "mobile_os_version_name_id"], :name => "mobiles_list_id", :unique => true

  create_table "link_f5_mobiles_lists", :force => true do |t|
    t.integer  "mobiles_list_id",      :limit => 8, :null => false
    t.integer  "mobile_os_version_id",              :null => false
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at"
  end

  add_index "link_f5_mobiles_lists", ["mobile_os_version_id"], :name => "fk1_links_operating_systems"
  add_index "link_f5_mobiles_lists", ["mobiles_list_id", "mobile_os_version_id"], :name => "mobiles_list_id", :unique => true

  create_table "link_f6_books_lists", :force => true do |t|
    t.integer  "books_list_id",      :limit => 8, :null => false
    t.integer  "publishing_date_id",              :null => false
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at"
  end

  add_index "link_f6_books_lists", ["books_list_id", "publishing_date_id"], :name => "books_list_id", :unique => true
  add_index "link_f6_books_lists", ["publishing_date_id"], :name => "fk_links_publishing_dates"

  create_table "link_f6_mobiles_lists", :force => true do |t|
    t.integer  "mobiles_list_id", :limit => 8, :null => false
    t.integer  "touch_screen_id",              :null => false
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at"
  end

  add_index "link_f6_mobiles_lists", ["mobiles_list_id", "touch_screen_id"], :name => "mobiles_list_id", :unique => true
  add_index "link_f6_mobiles_lists", ["touch_screen_id"], :name => "fk1_links_touch_screens"

  create_table "link_f7_books_lists", :force => true do |t|
    t.integer  "books_list_id", :limit => 8, :null => false
    t.integer  "publisher_id",               :null => false
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at"
  end

  add_index "link_f7_books_lists", ["books_list_id", "publisher_id"], :name => "books_list_id", :unique => true
  add_index "link_f7_books_lists", ["publisher_id"], :name => "fk_links_publishers"

  create_table "link_f7_mobiles_lists", :force => true do |t|
    t.integer  "mobiles_list_id",     :limit => 8, :null => false
    t.integer  "internal_storage_id",              :null => false
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at"
  end

  add_index "link_f7_mobiles_lists", ["internal_storage_id"], :name => "fk1_links_internal_storages"
  add_index "link_f7_mobiles_lists", ["mobiles_list_id", "internal_storage_id"], :name => "mobiles_list_id", :unique => true

  create_table "link_f8_books_lists", :force => true do |t|
    t.integer  "books_list_id", :limit => 8, :null => false
    t.integer  "edition_id",                 :null => false
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at"
  end

  add_index "link_f8_books_lists", ["books_list_id", "edition_id"], :name => "books_list_id", :unique => true
  add_index "link_f8_books_lists", ["edition_id"], :name => "fk_links_editions"

  create_table "link_f8_mobiles_lists", :force => true do |t|
    t.integer  "mobiles_list_id", :limit => 8, :null => false
    t.integer  "card_slot_id",                 :null => false
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at"
  end

  add_index "link_f8_mobiles_lists", ["card_slot_id"], :name => "fk1_links_card_slots"
  add_index "link_f8_mobiles_lists", ["mobiles_list_id", "card_slot_id"], :name => "mobiles_list_id", :unique => true

  create_table "link_f9_books_lists", :force => true do |t|
    t.integer  "books_list_id", :limit => 8, :null => false
    t.integer  "language_id",                :null => false
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at"
  end

  add_index "link_f9_books_lists", ["books_list_id", "language_id"], :name => "books_list_id", :unique => true
  add_index "link_f9_books_lists", ["language_id"], :name => "fk_links_languages"

  create_table "link_f9_mobiles_lists", :force => true do |t|
    t.integer  "mobiles_list_id",   :limit => 8, :null => false
    t.integer  "primary_camera_id",              :null => false
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at"
  end

  add_index "link_f9_mobiles_lists", ["mobiles_list_id", "primary_camera_id"], :name => "mobiles_list_id", :unique => true
  add_index "link_f9_mobiles_lists", ["primary_camera_id"], :name => "fk1_links_primary_cameras"

  create_table "link_products_lists_vendors", :primary_key => "unique_id", :force => true do |t|
    t.integer  "vendor_id",                     :null => false
    t.integer  "products_list_id", :limit => 8, :null => false
    t.integer  "sub_category_id",               :null => false
    t.integer  "availability_id",               :null => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at"
    t.integer  "pid"
  end

  add_index "link_products_lists_vendors", ["availability_id"], :name => "fk_link_products_lists_vendors_ma"
  add_index "link_products_lists_vendors", ["products_list_id"], :name => "fk_link_products_lists_vendors_m"
  add_index "link_products_lists_vendors", ["sub_category_id"], :name => "fk_link_products_lists_vendors_sc"
  add_index "link_products_lists_vendors", ["vendor_id", "products_list_id", "sub_category_id", "pid"], :name => "u_v_pl_s_p_id", :unique => true

  create_table "link_vendors_lists_branches", :force => true do |t|
    t.integer  "branch_id",  :null => false
    t.integer  "vendor_id",  :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at"
  end

  add_index "link_vendors_lists_branches", ["branch_id"], :name => "fk_link_vendors_lists_branches_2"
  add_index "link_vendors_lists_branches", ["vendor_id", "branch_id"], :name => "vendor_id", :unique => true

  create_table "link_vendors_lists_cities", :force => true do |t|
    t.integer  "city_id",    :null => false
    t.integer  "vendor_id",  :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at"
  end

  add_index "link_vendors_lists_cities", ["city_id"], :name => "fk_link_vendors_lists_cities_2"
  add_index "link_vendors_lists_cities", ["vendor_id", "city_id"], :name => "vendor_id", :unique => true

  create_table "link_vendors_lists_sub_categories", :primary_key => "link_id", :force => true do |t|
    t.integer  "vendor_id",       :null => false
    t.integer  "sub_category_id", :null => false
    t.datetime "created_at",      :null => false
    t.datetime "updated_at"
  end

  add_index "link_vendors_lists_sub_categories", ["sub_category_id"], :name => "fk_link_vendors_lists_subcategories_sub_categories"
  add_index "link_vendors_lists_sub_categories", ["vendor_id", "sub_category_id"], :name => "vendor_id", :unique => true

  create_table "local_chennai_adambakkam_cavetell_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_adambakkam_cavetell_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_adambakkam_rosemobiles_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_adambakkam_rosemobiles_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_adyar_citymobilecare_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_adyar_citymobilecare_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_adyar_fonecity_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_adyar_fonecity_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_adyar_helloworld_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_adyar_helloworld_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_adyar_mobilegallery_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_adyar_mobilegallery_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_adyar_romustelecom_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_adyar_romustelecom_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_adyar_samsungsmartphone_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_adyar_samsungsmartphone_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_adyar_vinodcellworld_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_adyar_vinodcellworld_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_alwarpet_gkmobilepark_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_alwarpet_gkmobilepark_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_alwarpet_planetm_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_alwarpet_planetm_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_alwarpet_simcity_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_alwarpet_simcity_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_alwarpet_studiocell_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_alwarpet_studiocell_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_ambattur_singaporecellpoint_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_ambattur_singaporecellpoint_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_aminjikarai_sayarsystems_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_aminjikarai_sayarsystems_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_annanagar_blackberrystore_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_annanagar_blackberrystore_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_annanagar_fonecity_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_annanagar_fonecity_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_annanagar_mobilegallery_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_annanagar_mobilegallery_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_annanagar_samsungsmartphone_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_annanagar_samsungsmartphone_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_annanagar_sonyworld_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_annanagar_sonyworld_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_annanagar_sonyxperiastore_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_annanagar_sonyxperiastore_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_annasalai_sonycenter_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_annasalai_sonycenter_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_arumbakkam_teczone_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_arumbakkam_teczone_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_ashoknagar_mobileshoppe_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_ashoknagar_mobileshoppe_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_ashoknagar_sonycenter_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_ashoknagar_sonycenter_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_besantnagar_mmrcommunication_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_besantnagar_mmrcommunication_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_besantnagar_vinodcellworld_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_besantnagar_vinodcellworld_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_choolaimedu_rosemobiles_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_choolaimedu_rosemobiles_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_chrompet_anandacellcity_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_chrompet_anandacellcity_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_egmore_pritamcommunications_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_egmore_pritamcommunications_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_karayanchavadi_mobileinn_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_karayanchavadi_mobileinn_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_kilkattalai_rosemobiles_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_kilkattalai_rosemobiles_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_kilpauk_cellzone_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_kilpauk_cellzone_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_kilpauk_chennaicellpoint_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_kilpauk_chennaicellpoint_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_kilpauk_kwalityshop_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_kilpauk_kwalityshop_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_kilpauk_samsungplazasrees_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_kilpauk_samsungplazasrees_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_kodambakkam_cellking_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_kodambakkam_cellking_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_kottivakkam_esquiretradings_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_kottivakkam_esquiretradings_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_kottivakkam_samsungsmartphonecafe_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_kottivakkam_samsungsmartphonecafe_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_kottivakkam_samsungsphonecafe_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_kottivakkam_samsungsphonecafe_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_koyambedu_thechennaimobiles_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_koyambedu_thechennaimobiles_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_kundrathur_hitech_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_kundrathur_hitech_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_mambalam_sayarsystems_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_mambalam_sayarsystems_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_medavakkam_uniquecellcare_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_medavakkam_uniquecellcare_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_mylapore_seashoreshowroom_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_mylapore_seashoreshowroom_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_mylapore_smartcell_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_mylapore_smartcell_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_neelankarai_electronect_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_neelankarai_electronect_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_neelankarai_simcity_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_neelankarai_simcity_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_nungambakkam_access_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_nungambakkam_access_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_nungambakkam_aikoncommunications_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_nungambakkam_aikoncommunications_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_nungambakkam_currents_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_nungambakkam_currents_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_nungambakkam_eworld_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_nungambakkam_eworld_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_nungambakkam_sonycenter_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_nungambakkam_sonycenter_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_nungambakkam_zamzammobile_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_nungambakkam_zamzammobile_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_pattalam_mobilegallery_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_pattalam_mobilegallery_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_perambur_mobilegallery_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_perambur_mobilegallery_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_perambur_rosemobiles_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_perambur_rosemobiles_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_porur_skytel_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_porur_skytel_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_porur_smartcell_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_porur_smartcell_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_porur_sonycenter_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_porur_sonycenter_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_purasawakkam_easycellcity_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_purasawakkam_easycellcity_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_purasawakkam_gadgetworld_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_purasawakkam_gadgetworld_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_rapuram_romustelecom_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_rapuram_romustelecom_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_royapettah_access_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_royapettah_access_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_royapettah_planetm_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_royapettah_planetm_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_royapettah_samsungsphonecafe_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_royapettah_samsungsphonecafe_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_saidapet_itscellzone_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_saidapet_itscellzone_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_saligramam_thanujamobileworld_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_saligramam_thanujamobileworld_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_seevaram_expressmobiles_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_seevaram_expressmobiles_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_selaiyur_anandacellcity_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_selaiyur_anandacellcity_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_sholinganallur_landmarkscommn_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_sholinganallur_landmarkscommn_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_tambaram_stmobiles_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_tambaram_stmobiles_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_taramani_uniquecellcare_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_taramani_uniquecellcare_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_thiruvanmiyur_adyarnethuts_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_thiruvanmiyur_adyarnethuts_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_thiruvanmiyur_kwalityshop_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_thiruvanmiyur_kwalityshop_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_thiruvanmiyur_sathyaagencies_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_thiruvanmiyur_sathyaagencies_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_thiruvanmiyur_uniquecellcare_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_thiruvanmiyur_uniquecellcare_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_thousandlights_mobileparadise_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_thousandlights_mobileparadise_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_thousandlights_twentymobiles_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_thousandlights_twentymobiles_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_thuraipakkam_helloworld_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_thuraipakkam_helloworld_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_thuraipakkam_samsungsmartphone_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_thuraipakkam_samsungsmartphone_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_tnagar_gadgetworld_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_tnagar_gadgetworld_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_tnagar_likemobiles_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_tnagar_likemobiles_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_tnagar_matrix_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_tnagar_matrix_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_tnagar_milkywaycelltech_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_tnagar_milkywaycelltech_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_tnagar_pujas_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_tnagar_pujas_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_tnagar_queenszone_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_tnagar_queenszone_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_tnagar_samsungsmartphonecafe_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_tnagar_samsungsmartphonecafe_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_tnagar_studiocell_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_tnagar_studiocell_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_triplicane_samsungsmartphonecafe_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_triplicane_samsungsmartphonecafe_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_vadapalani_applemobilestore_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_vadapalani_applemobilestore_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_vadapalani_bbcelectronics_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_vadapalani_bbcelectronics_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_valasaravakkam_mobileshopping_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_valasaravakkam_mobileshopping_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_velachery_csmworld_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_velachery_csmworld_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_velachery_jaisaimobiles_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_velachery_jaisaimobiles_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_velachery_jeevasmobiles_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_velachery_jeevasmobiles_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_velachery_simcity_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_velachery_simcity_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_velachery_sonyxperiastore_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_velachery_sonyxperiastore_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_villivakkam_maximumcommunication_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_villivakkam_maximumcommunication_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_virugambakkam_samsungcafe_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_virugambakkam_samsungcafe_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_chennai_virugambakkam_samsungsmartphonecafe_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  add_index "local_chennai_virugambakkam_samsungsmartphonecafe_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "local_grid_details", :primary_key => "unique_id", :force => true do |t|
    t.float    "price",                       :null => false
    t.string   "availability",                :null => false
    t.string   "delivery",       :limit => 1, :null => false
    t.string   "delivery_time"
    t.float    "delivery_cost"
    t.text     "special_offers"
    t.text     "warranty"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at"
  end

  create_table "local_merchant_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                                         :null => false
    t.text     "product_image_url"
    t.string   "product_category",                                     :null => false
    t.string   "product_sub_category",                                 :null => false
    t.string   "product_identifier1",                                  :null => false
    t.string   "product_identifier2",                                  :null => false
    t.float    "product_price",                                        :null => false
    t.string   "product_availability",                                 :null => false
    t.string   "product_delivery",       :limit => 1,                  :null => false
    t.string   "product_delivery_time"
    t.float    "product_delivery_cost",               :default => 0.0
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                                               :null => false
    t.string   "validity",                                             :null => false
    t.string   "configured_by",                                        :null => false
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
    t.integer  "part1_product_id",       :limit => 8,                  :null => false
    t.integer  "vendor_id",                                            :null => false
    t.string   "vendor_table_name",                                    :null => false
    t.string   "action",                                               :null => false
  end

  add_index "local_merchant_products", ["vendor_id"], :name => "fk_local_merchant_products_vendors"

  create_table "local_price_list_details", :force => true do |t|
    t.string   "brand_name",       :null => false
    t.integer  "vendor_id",        :null => false
    t.string   "brand_logo",       :null => false
    t.string   "distributor_name", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "local_price_list_details", ["vendor_id", "brand_name"], :name => "vendor_id", :unique => true

  create_table "local_price_list_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",  :null => false
    t.float    "product_price", :null => false
    t.integer  "vendor_id",     :null => false
    t.string   "action",        :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "memory_cards_f1_features", :primary_key => "feature_id", :force => true do |t|
    t.text     "feature_name", :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at"
  end

  create_table "memory_cards_lists", :primary_key => "memory_cards_list_id", :force => true do |t|
    t.string   "memory_card_name",                                            :null => false
    t.string   "memory_card_part_no",                                         :null => false
    t.text     "memory_card_image_url"
    t.string   "memory_card_brand",                                           :null => false
    t.string   "memory_card_type",                                            :null => false
    t.text     "memory_card_features",                                        :null => false
    t.string   "memory_card_availability_flag", :limit => 1, :default => "y", :null => false
    t.datetime "created_at",                                                  :null => false
    t.datetime "updated_at"
    t.text     "name_slug"
    t.text     "identifier_slug"
  end

  add_index "memory_cards_lists", ["memory_card_name", "memory_card_part_no"], :name => "name_id", :unique => true

  create_table "memory_cards_rates", :force => true do |t|
    t.integer  "memory_cards_list_id",         :limit => 8,                  :null => false
    t.text     "memory_card_price_source_url",                               :null => false
    t.float    "dp_tamilnadu"
    t.float    "mrp",                                       :default => 0.0
    t.datetime "created_at",                                                 :null => false
    t.datetime "updated_at"
  end

  create_table "memory_cards_vendor_f2_availabilities", :primary_key => "availability_id", :force => true do |t|
    t.string   "availability", :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at"
  end

  add_index "memory_cards_vendor_f2_availabilities", ["availability"], :name => "availability", :unique => true

  create_table "merchants", :primary_key => "merchant_id", :force => true do |t|
    t.string   "login_type",    :limit => 20, :default => "branch"
    t.string   "login_name",                                        :null => false
    t.string   "password_hash",                                     :null => false
    t.string   "password_salt",                                     :null => false
    t.string   "table_name"
    t.string   "business_type",                                     :null => false
    t.integer  "vendor_id",                                         :null => false
    t.datetime "created_at",                                        :null => false
    t.datetime "updated_at"
  end

  add_index "merchants", ["login_name"], :name => "login_name", :unique => true
  add_index "merchants", ["vendor_id"], :name => "fk_merchants_vendors"

  create_table "merchants_lists", :primary_key => "merchants_list_id", :force => true do |t|
    t.string   "merchant_name",                          :null => false
    t.text     "merchant_logo",                          :null => false
    t.text     "merchant_description"
    t.string   "business_type",                          :null => false
    t.string   "merchant_website"
    t.string   "merchant_email"
    t.string   "merchant_phone",                         :null => false
    t.string   "merchant_fax"
    t.text     "merchant_address",                       :null => false
    t.string   "latitude",             :default => "na"
    t.string   "longitude",            :default => "na"
    t.string   "city_name"
    t.string   "branch_name"
    t.integer  "merchant_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "merchants_lists", ["merchant_id"], :name => "merchant_id", :unique => true
  add_index "merchants_lists", ["merchant_name", "business_type", "city_name", "branch_name"], :name => "merchant_name", :unique => true

  create_table "merchants_password_requests", :primary_key => "request_id", :force => true do |t|
    t.text     "request",                     :null => false
    t.string   "request_type",                :null => false
    t.integer  "merchant_id",                 :null => false
    t.integer  "served",       :default => 0, :null => false
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at"
  end

  create_table "metatags", :primary_key => "metatag_id", :force => true do |t|
    t.string   "metatag",         :null => false
    t.string   "model_name",      :null => false
    t.string   "column_name",     :null => false
    t.integer  "primary_id",      :null => false
    t.integer  "sub_category_id", :null => false
    t.datetime "created_at",      :null => false
    t.datetime "updated_at"
  end

  add_index "metatags", ["model_name", "column_name", "primary_id", "metatag"], :name => "model_name", :unique => true

  create_table "mobile_brands", :primary_key => "mobile_brands_id", :force => true do |t|
    t.string   "mobile_brand_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mobile_reviews", :primary_key => "mobile_reviews_list_id", :force => true do |t|
    t.string   "mobile_name",                 :null => false
    t.text     "review_landing_external_url", :null => false
    t.text     "review_landing_video_url",    :null => false
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at"
  end

  add_index "mobile_reviews", ["mobile_name"], :name => "mobile_name", :unique => true

  create_table "mobiles_f10_secondary_cameras", :primary_key => "secondary_camera_id", :force => true do |t|
    t.string   "secondary_camera", :null => false
    t.datetime "created_at",       :null => false
    t.datetime "updated_at"
  end

  add_index "mobiles_f10_secondary_cameras", ["secondary_camera"], :name => "secondary_camera", :unique => true

  create_table "mobiles_f11_processors", :primary_key => "processor_id", :force => true do |t|
    t.string   "processor",  :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at"
  end

  add_index "mobiles_f11_processors", ["processor"], :name => "processor", :unique => true

  create_table "mobiles_f12_messagings", :primary_key => "messaging_id", :force => true do |t|
    t.string   "messaging_name", :null => false
    t.datetime "created_at",     :null => false
    t.datetime "updated_at"
  end

  add_index "mobiles_f12_messagings", ["messaging_name"], :name => "messaging_name", :unique => true

  create_table "mobiles_f13_browsers", :primary_key => "browser_id", :force => true do |t|
    t.string   "browser_name", :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at"
  end

  add_index "mobiles_f13_browsers", ["browser_name"], :name => "browser_name", :unique => true

  create_table "mobiles_f14_mobile_rams", :primary_key => "mobile_ram_id", :force => true do |t|
    t.string   "mobile_ram", :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at"
  end

  add_index "mobiles_f14_mobile_rams", ["mobile_ram"], :name => "mobile_ram", :unique => true

  create_table "mobiles_f15_assorteds", :primary_key => "assorteds_id", :force => true do |t|
    t.string   "assorteds_name", :null => false
    t.datetime "created_at",     :null => false
    t.datetime "updated_at"
  end

  add_index "mobiles_f15_assorteds", ["assorteds_name"], :name => "assorteds_name", :unique => true

  create_table "mobiles_f1_mobile_brands", :primary_key => "mobile_brand_id", :force => true do |t|
    t.string   "mobile_brand_name", :null => false
    t.datetime "created_at",        :null => false
    t.datetime "updated_at"
  end

  add_index "mobiles_f1_mobile_brands", ["mobile_brand_name"], :name => "mobile_brand_name", :unique => true

  create_table "mobiles_f2_mobile_colors", :primary_key => "mobile_color_id", :force => true do |t|
    t.string   "mobile_color_name", :null => false
    t.datetime "created_at",        :null => false
    t.datetime "updated_at"
  end

  add_index "mobiles_f2_mobile_colors", ["mobile_color_name"], :name => "mobile_color_name", :unique => true

  create_table "mobiles_f3_mobile_types", :primary_key => "mobile_type_id", :force => true do |t|
    t.string   "mobile_type_name", :null => false
    t.datetime "created_at",       :null => false
    t.datetime "updated_at"
  end

  add_index "mobiles_f3_mobile_types", ["mobile_type_name"], :name => "mobile_type_name", :unique => true

  create_table "mobiles_f4_mobile_designs", :primary_key => "mobile_design_id", :force => true do |t|
    t.string   "mobile_design_name", :null => false
    t.datetime "created_at",         :null => false
    t.datetime "updated_at"
  end

  add_index "mobiles_f4_mobile_designs", ["mobile_design_name"], :name => "mobile_design_name", :unique => true

  create_table "mobiles_f5_c_os_version_names", :primary_key => "mobile_os_version_name_id", :force => true do |t|
    t.string   "mobile_os_version_name", :null => false
    t.datetime "created_at",             :null => false
    t.datetime "updated_at"
  end

  add_index "mobiles_f5_c_os_version_names", ["mobile_os_version_name"], :name => "mobile_os_version_name", :unique => true

  create_table "mobiles_f5_os_versions", :primary_key => "mobile_os_version_id", :force => true do |t|
    t.string   "mobile_os_version",                        :null => false
    t.integer  "mobile_os_version_name_id", :default => 0
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at"
  end

  add_index "mobiles_f5_os_versions", ["mobile_os_version", "mobile_os_version_name_id"], :name => "mobile_os_version", :unique => true

  create_table "mobiles_f6_touch_screens", :primary_key => "touch_screen_id", :force => true do |t|
    t.string   "touch_screen_name", :null => false
    t.datetime "created_at",        :null => false
    t.datetime "updated_at"
  end

  add_index "mobiles_f6_touch_screens", ["touch_screen_name"], :name => "touch_screen_name", :unique => true

  create_table "mobiles_f7_internal_storages", :primary_key => "internal_storage_id", :force => true do |t|
    t.string   "internal_storage_name", :null => false
    t.datetime "created_at",            :null => false
    t.datetime "updated_at"
  end

  add_index "mobiles_f7_internal_storages", ["internal_storage_name"], :name => "internal_storage_name", :unique => true

  create_table "mobiles_f8_card_slots", :primary_key => "card_slot_id", :force => true do |t|
    t.string   "card_slots", :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at"
  end

  add_index "mobiles_f8_card_slots", ["card_slots"], :name => "card_slots", :unique => true

  create_table "mobiles_f9_primary_cameras", :primary_key => "primary_camera_id", :force => true do |t|
    t.string   "primary_camera", :null => false
    t.datetime "created_at",     :null => false
    t.datetime "updated_at"
  end

  add_index "mobiles_f9_primary_cameras", ["primary_camera"], :name => "primary_camera", :unique => true

  create_table "mobiles_lists", :primary_key => "mobiles_list_id", :force => true do |t|
    t.string   "mobile_name",                                            :null => false
    t.text     "mobile_image_url"
    t.text     "mobile_features",                                        :null => false
    t.string   "mobile_brand",                                           :null => false
    t.string   "mobile_color",                                           :null => false
    t.string   "mobile_availability_flag", :limit => 1, :default => "y"
    t.datetime "created_at",                                             :null => false
    t.datetime "updated_at"
    t.text     "name_slug"
    t.text     "identifier_slug"
  end

  add_index "mobiles_lists", ["mobile_name"], :name => "u_name", :unique => true

  create_table "mobiles_rates", :force => true do |t|
    t.integer  "mobiles_list_id", :limit => 8, :null => false
    t.float    "mrp"
    t.float    "dp_tamilnadu"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at"
  end

  create_table "mobiles_vendor_f16_availabilities", :primary_key => "availability_id", :force => true do |t|
    t.string   "availability", :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at"
  end

  add_index "mobiles_vendor_f16_availabilities", ["availability"], :name => "availability", :unique => true

  create_table "mouses_f1_features", :primary_key => "feature_id", :force => true do |t|
    t.text     "feature_name", :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at"
  end

  create_table "mouses_lists", :primary_key => "mouses_list_id", :force => true do |t|
    t.string   "mouse_name",                                            :null => false
    t.string   "mouse_part_no",                                         :null => false
    t.text     "mouse_image_url"
    t.string   "mouse_brand",                                           :null => false
    t.string   "mouse_color",                                           :null => false
    t.text     "mouse_features",                                        :null => false
    t.string   "mouse_availability_flag", :limit => 1, :default => "y", :null => false
    t.datetime "created_at",                                            :null => false
    t.datetime "updated_at"
    t.text     "name_slug"
    t.text     "identifier_slug"
  end

  add_index "mouses_lists", ["mouse_name", "mouse_part_no"], :name => "name_id", :unique => true

  create_table "mouses_rates", :force => true do |t|
    t.integer  "mouses_list_id",         :limit => 8,                  :null => false
    t.text     "mouse_price_source_url",                               :null => false
    t.float    "dp_tamilnadu"
    t.float    "mrp",                                 :default => 0.0
    t.datetime "created_at",                                           :null => false
    t.datetime "updated_at"
  end

  create_table "mouses_vendor_f2_availabilities", :primary_key => "availability_id", :force => true do |t|
    t.string   "availability", :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at"
  end

  add_index "mouses_vendor_f2_availabilities", ["availability"], :name => "availability", :unique => true

  create_table "na", :id => false, :force => true do |t|
    t.integer "a"
  end

  create_table "nearby_2kms_branches", :force => true do |t|
    t.integer  "city_id",    :null => false
    t.integer  "branch_id",  :null => false
    t.integer  "area_id",    :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at"
  end

  create_table "nearby_4kms_branches", :force => true do |t|
    t.integer  "city_id",    :null => false
    t.integer  "branch_id",  :null => false
    t.integer  "area_id",    :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at"
  end

  create_table "nearby_6kms_branches", :force => true do |t|
    t.integer  "city_id",    :null => false
    t.integer  "branch_id",  :null => false
    t.integer  "area_id",    :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at"
  end

  create_table "online_bigbuy_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",           :null => false
    t.text     "product_image_url"
    t.string   "product_category",       :null => false
    t.string   "product_sub_category",   :null => false
    t.string   "product_identifier1",    :null => false
    t.string   "product_identifier2",    :null => false
    t.float    "product_price",          :null => false
    t.float    "product_shipping_cost",  :null => false
    t.string   "product_shipping_time",  :null => false
    t.string   "product_availability",   :null => false
    t.text     "product_redirect_url",   :null => false
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                 :null => false
    t.string   "validity",               :null => false
    t.string   "configured_by",          :null => false
    t.datetime "created_at",             :null => false
    t.datetime "updated_at"
  end

  add_index "online_bigbuy_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "online_buytheprice_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",           :null => false
    t.text     "product_image_url"
    t.string   "product_category",       :null => false
    t.string   "product_sub_category",   :null => false
    t.string   "product_identifier1",    :null => false
    t.string   "product_identifier2",    :null => false
    t.float    "product_price",          :null => false
    t.float    "product_shipping_cost",  :null => false
    t.string   "product_shipping_time",  :null => false
    t.string   "product_availability",   :null => false
    t.text     "product_redirect_url",   :null => false
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                 :null => false
    t.string   "validity",               :null => false
    t.string   "configured_by",          :null => false
    t.datetime "created_at",             :null => false
    t.datetime "updated_at"
  end

  add_index "online_buytheprice_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "online_croma_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",           :null => false
    t.text     "product_image_url"
    t.string   "product_category",       :null => false
    t.string   "product_sub_category",   :null => false
    t.string   "product_identifier1",    :null => false
    t.string   "product_identifier2",    :null => false
    t.float    "product_price",          :null => false
    t.float    "product_shipping_cost",  :null => false
    t.string   "product_shipping_time",  :null => false
    t.string   "product_availability",   :null => false
    t.text     "product_redirect_url",   :null => false
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                 :null => false
    t.string   "validity",               :null => false
    t.string   "configured_by",          :null => false
    t.datetime "created_at",             :null => false
    t.datetime "updated_at"
  end

  add_index "online_croma_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "online_crossword_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",           :null => false
    t.text     "product_image_url"
    t.string   "product_category",       :null => false
    t.string   "product_sub_category",   :null => false
    t.string   "product_identifier1",    :null => false
    t.string   "product_identifier2",    :null => false
    t.float    "product_price",          :null => false
    t.float    "product_shipping_cost",  :null => false
    t.string   "product_shipping_time",  :null => false
    t.string   "product_availability",   :null => false
    t.text     "product_redirect_url",   :null => false
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                 :null => false
    t.string   "validity",               :null => false
    t.string   "configured_by",          :null => false
    t.datetime "created_at",             :null => false
    t.datetime "updated_at"
  end

  add_index "online_crossword_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "online_edabba_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",           :null => false
    t.text     "product_image_url"
    t.string   "product_category",       :null => false
    t.string   "product_sub_category",   :null => false
    t.string   "product_identifier1",    :null => false
    t.string   "product_identifier2",    :null => false
    t.float    "product_price",          :null => false
    t.float    "product_shipping_cost",  :null => false
    t.string   "product_shipping_time",  :null => false
    t.string   "product_availability",   :null => false
    t.text     "product_redirect_url",   :null => false
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                 :null => false
    t.string   "validity",               :null => false
    t.string   "configured_by",          :null => false
    t.datetime "created_at",             :null => false
    t.datetime "updated_at"
  end

  add_index "online_edabba_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "online_flipkart_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",           :null => false
    t.text     "product_image_url"
    t.string   "product_category",       :null => false
    t.string   "product_sub_category",   :null => false
    t.string   "product_identifier1",    :null => false
    t.string   "product_identifier2",    :null => false
    t.float    "product_price",          :null => false
    t.float    "product_shipping_cost",  :null => false
    t.string   "product_shipping_time",  :null => false
    t.string   "product_availability",   :null => false
    t.text     "product_redirect_url",   :null => false
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                 :null => false
    t.string   "validity",               :null => false
    t.string   "configured_by",          :null => false
    t.datetime "created_at",             :null => false
    t.datetime "updated_at"
  end

  add_index "online_flipkart_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "online_futurebazaar_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",           :null => false
    t.text     "product_image_url"
    t.string   "product_category",       :null => false
    t.string   "product_sub_category",   :null => false
    t.string   "product_identifier1",    :null => false
    t.string   "product_identifier2",    :null => false
    t.float    "product_price",          :null => false
    t.float    "product_shipping_cost",  :null => false
    t.string   "product_shipping_time",  :null => false
    t.string   "product_availability",   :null => false
    t.text     "product_redirect_url",   :null => false
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                 :null => false
    t.string   "validity",               :null => false
    t.string   "configured_by",          :null => false
    t.datetime "created_at",             :null => false
    t.datetime "updated_at"
  end

  add_index "online_futurebazaar_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "online_gadgetsguru_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",           :null => false
    t.text     "product_image_url"
    t.string   "product_category",       :null => false
    t.string   "product_sub_category",   :null => false
    t.string   "product_identifier1",    :null => false
    t.string   "product_identifier2",    :null => false
    t.float    "product_price",          :null => false
    t.float    "product_shipping_cost",  :null => false
    t.string   "product_shipping_time",  :null => false
    t.string   "product_availability",   :null => false
    t.text     "product_redirect_url",   :null => false
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                 :null => false
    t.string   "validity",               :null => false
    t.string   "configured_by",          :null => false
    t.datetime "created_at",             :null => false
    t.datetime "updated_at"
  end

  add_index "online_gadgetsguru_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "online_grabmore_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",           :null => false
    t.text     "product_image_url"
    t.string   "product_category",       :null => false
    t.string   "product_sub_category",   :null => false
    t.string   "product_identifier1",    :null => false
    t.string   "product_identifier2",    :null => false
    t.float    "product_price",          :null => false
    t.float    "product_shipping_cost",  :null => false
    t.string   "product_shipping_time",  :null => false
    t.string   "product_availability",   :null => false
    t.text     "product_redirect_url",   :null => false
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                 :null => false
    t.string   "validity",               :null => false
    t.string   "configured_by",          :null => false
    t.datetime "created_at",             :null => false
    t.datetime "updated_at"
  end

  add_index "online_grabmore_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "online_greendust_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",           :null => false
    t.text     "product_image_url"
    t.string   "product_category",       :null => false
    t.string   "product_sub_category",   :null => false
    t.string   "product_identifier1",    :null => false
    t.string   "product_identifier2",    :null => false
    t.float    "product_price",          :null => false
    t.float    "product_shipping_cost",  :null => false
    t.string   "product_shipping_time",  :null => false
    t.string   "product_availability",   :null => false
    t.text     "product_redirect_url",   :null => false
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                 :null => false
    t.string   "validity",               :null => false
    t.string   "configured_by",          :null => false
    t.datetime "created_at",             :null => false
    t.datetime "updated_at"
  end

  add_index "online_greendust_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "online_grid_details", :primary_key => "unique_id", :force => true do |t|
    t.float    "price",          :null => false
    t.text     "redirect_url",   :null => false
    t.string   "shipping_time",  :null => false
    t.float    "shipping_cost",  :null => false
    t.string   "availability",   :null => false
    t.text     "special_offers"
    t.text     "warranty"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at"
    t.string   "name"
  end

  create_table "online_homeshop18_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",           :null => false
    t.text     "product_image_url"
    t.string   "product_category",       :null => false
    t.string   "product_sub_category",   :null => false
    t.string   "product_identifier1",    :null => false
    t.string   "product_identifier2",    :null => false
    t.float    "product_price",          :null => false
    t.float    "product_shipping_cost",  :null => false
    t.string   "product_shipping_time",  :null => false
    t.string   "product_availability",   :null => false
    t.text     "product_redirect_url",   :null => false
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                 :null => false
    t.string   "validity",               :null => false
    t.string   "configured_by",          :null => false
    t.datetime "created_at",             :null => false
    t.datetime "updated_at"
  end

  add_index "online_homeshop18_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "online_indiaplaza_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",           :null => false
    t.text     "product_image_url"
    t.string   "product_category",       :null => false
    t.string   "product_sub_category",   :null => false
    t.string   "product_identifier1",    :null => false
    t.string   "product_identifier2",    :null => false
    t.float    "product_price",          :null => false
    t.float    "product_shipping_cost",  :null => false
    t.string   "product_shipping_time",  :null => false
    t.string   "product_availability",   :null => false
    t.text     "product_redirect_url",   :null => false
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                 :null => false
    t.string   "validity",               :null => false
    t.string   "configured_by",          :null => false
    t.datetime "created_at",             :null => false
    t.datetime "updated_at"
  end

  add_index "online_indiaplaza_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "online_indiatimes_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",           :null => false
    t.text     "product_image_url"
    t.string   "product_category",       :null => false
    t.string   "product_sub_category",   :null => false
    t.string   "product_identifier1",    :null => false
    t.string   "product_identifier2",    :null => false
    t.float    "product_price",          :null => false
    t.float    "product_shipping_cost",  :null => false
    t.string   "product_shipping_time",  :null => false
    t.string   "product_availability",   :null => false
    t.text     "product_redirect_url",   :null => false
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                 :null => false
    t.string   "validity",               :null => false
    t.string   "configured_by",          :null => false
    t.datetime "created_at",             :null => false
    t.datetime "updated_at"
  end

  add_index "online_indiatimes_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "online_infibeam_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",           :null => false
    t.text     "product_image_url"
    t.string   "product_category",       :null => false
    t.string   "product_sub_category",   :null => false
    t.string   "product_identifier1",    :null => false
    t.string   "product_identifier2",    :null => false
    t.float    "product_price",          :null => false
    t.float    "product_shipping_cost",  :null => false
    t.string   "product_shipping_time",  :null => false
    t.string   "product_availability",   :null => false
    t.text     "product_redirect_url",   :null => false
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                 :null => false
    t.string   "validity",               :null => false
    t.string   "configured_by",          :null => false
    t.datetime "created_at",             :null => false
    t.datetime "updated_at"
  end

  add_index "online_infibeam_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "online_landmark_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",           :null => false
    t.text     "product_image_url"
    t.string   "product_category",       :null => false
    t.string   "product_sub_category",   :null => false
    t.string   "product_identifier1",    :null => false
    t.string   "product_identifier2",    :null => false
    t.float    "product_price",          :null => false
    t.float    "product_shipping_cost",  :null => false
    t.string   "product_shipping_time",  :null => false
    t.string   "product_availability",   :null => false
    t.text     "product_redirect_url",   :null => false
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                 :null => false
    t.string   "validity",               :null => false
    t.string   "configured_by",          :null => false
    t.datetime "created_at",             :null => false
    t.datetime "updated_at"
  end

  add_index "online_landmark_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "online_maniacstore_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",           :null => false
    t.text     "product_image_url"
    t.string   "product_category",       :null => false
    t.string   "product_sub_category",   :null => false
    t.string   "product_identifier1",    :null => false
    t.string   "product_identifier2",    :null => false
    t.float    "product_price",          :null => false
    t.float    "product_shipping_cost",  :null => false
    t.string   "product_shipping_time",  :null => false
    t.string   "product_availability",   :null => false
    t.text     "product_redirect_url",   :null => false
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                 :null => false
    t.string   "validity",               :null => false
    t.string   "configured_by",          :null => false
    t.datetime "created_at",             :null => false
    t.datetime "updated_at"
  end

  add_index "online_maniacstore_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "online_merchant_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",                        :null => false
    t.text     "product_image_url"
    t.string   "product_category",                    :null => false
    t.string   "product_sub_category",                :null => false
    t.string   "product_identifier1",                 :null => false
    t.string   "product_identifier2",                 :null => false
    t.float    "product_price",                       :null => false
    t.float    "product_shipping_cost",               :null => false
    t.string   "product_shipping_time",               :null => false
    t.string   "product_availability",                :null => false
    t.text     "product_redirect_url",                :null => false
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                              :null => false
    t.string   "validity",                            :null => false
    t.string   "configured_by",                       :null => false
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at"
    t.integer  "part1_product_id",       :limit => 8, :null => false
    t.integer  "vendor_id",                           :null => false
    t.string   "vendor_table_name",                   :null => false
    t.string   "action",                              :null => false
  end

  add_index "online_merchant_products", ["vendor_id"], :name => "fk_online_merchant_products_vendors"

  create_table "online_mirchimart_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",           :null => false
    t.text     "product_image_url"
    t.string   "product_category",       :null => false
    t.string   "product_sub_category",   :null => false
    t.string   "product_identifier1",    :null => false
    t.string   "product_identifier2",    :null => false
    t.float    "product_price",          :null => false
    t.float    "product_shipping_cost",  :null => false
    t.string   "product_shipping_time",  :null => false
    t.string   "product_availability",   :null => false
    t.text     "product_redirect_url",   :null => false
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                 :null => false
    t.string   "validity",               :null => false
    t.string   "configured_by",          :null => false
    t.datetime "created_at",             :null => false
    t.datetime "updated_at"
  end

  add_index "online_mirchimart_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "online_nikishop_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",           :null => false
    t.text     "product_image_url"
    t.string   "product_category",       :null => false
    t.string   "product_sub_category",   :null => false
    t.string   "product_identifier1",    :null => false
    t.string   "product_identifier2",    :null => false
    t.float    "product_price",          :null => false
    t.float    "product_shipping_cost",  :null => false
    t.string   "product_shipping_time",  :null => false
    t.string   "product_availability",   :null => false
    t.text     "product_redirect_url",   :null => false
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                 :null => false
    t.string   "validity",               :null => false
    t.string   "configured_by",          :null => false
    t.datetime "created_at",             :null => false
    t.datetime "updated_at"
  end

  add_index "online_nikishop_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "online_poorvika_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",           :null => false
    t.text     "product_image_url"
    t.string   "product_category",       :null => false
    t.string   "product_sub_category",   :null => false
    t.string   "product_identifier1",    :null => false
    t.string   "product_identifier2",    :null => false
    t.float    "product_price",          :null => false
    t.float    "product_shipping_cost",  :null => false
    t.string   "product_shipping_time",  :null => false
    t.string   "product_availability",   :null => false
    t.text     "product_redirect_url",   :null => false
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                 :null => false
    t.string   "validity",               :null => false
    t.string   "configured_by",          :null => false
    t.datetime "created_at",             :null => false
    t.datetime "updated_at"
  end

  add_index "online_poorvika_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "online_saholic_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",           :null => false
    t.text     "product_image_url"
    t.string   "product_category",       :null => false
    t.string   "product_sub_category",   :null => false
    t.string   "product_identifier1",    :null => false
    t.string   "product_identifier2",    :null => false
    t.float    "product_price",          :null => false
    t.float    "product_shipping_cost",  :null => false
    t.string   "product_shipping_time",  :null => false
    t.string   "product_availability",   :null => false
    t.text     "product_redirect_url",   :null => false
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                 :null => false
    t.string   "validity",               :null => false
    t.string   "configured_by",          :null => false
    t.datetime "created_at",             :null => false
    t.datetime "updated_at"
  end

  add_index "online_saholic_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "online_sangeetha_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",           :null => false
    t.text     "product_image_url"
    t.string   "product_category",       :null => false
    t.string   "product_sub_category",   :null => false
    t.string   "product_identifier1",    :null => false
    t.string   "product_identifier2",    :null => false
    t.float    "product_price",          :null => false
    t.float    "product_shipping_cost",  :null => false
    t.string   "product_shipping_time",  :null => false
    t.string   "product_availability",   :null => false
    t.text     "product_redirect_url",   :null => false
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                 :null => false
    t.string   "validity",               :null => false
    t.string   "configured_by",          :null => false
    t.datetime "created_at",             :null => false
    t.datetime "updated_at"
  end

  add_index "online_sangeetha_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "online_shopclues_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",           :null => false
    t.text     "product_image_url"
    t.string   "product_category",       :null => false
    t.string   "product_sub_category",   :null => false
    t.string   "product_identifier1",    :null => false
    t.string   "product_identifier2",    :null => false
    t.float    "product_price",          :null => false
    t.float    "product_shipping_cost",  :null => false
    t.string   "product_shipping_time",  :null => false
    t.string   "product_availability",   :null => false
    t.text     "product_redirect_url",   :null => false
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                 :null => false
    t.string   "validity",               :null => false
    t.string   "configured_by",          :null => false
    t.datetime "created_at",             :null => false
    t.datetime "updated_at"
  end

  add_index "online_shopclues_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "online_snapdeal_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",           :null => false
    t.text     "product_image_url"
    t.string   "product_category",       :null => false
    t.string   "product_sub_category",   :null => false
    t.string   "product_identifier1",    :null => false
    t.string   "product_identifier2",    :null => false
    t.float    "product_price",          :null => false
    t.float    "product_shipping_cost",  :null => false
    t.string   "product_shipping_time",  :null => false
    t.string   "product_availability",   :null => false
    t.text     "product_redirect_url",   :null => false
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                 :null => false
    t.string   "validity",               :null => false
    t.string   "configured_by",          :null => false
    t.datetime "created_at",             :null => false
    t.datetime "updated_at"
  end

  add_index "online_snapdeal_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "online_themobilestore_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",           :null => false
    t.text     "product_image_url"
    t.string   "product_category",       :null => false
    t.string   "product_sub_category",   :null => false
    t.string   "product_identifier1",    :null => false
    t.string   "product_identifier2",    :null => false
    t.float    "product_price",          :null => false
    t.float    "product_shipping_cost",  :null => false
    t.string   "product_shipping_time",  :null => false
    t.string   "product_availability",   :null => false
    t.text     "product_redirect_url",   :null => false
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                 :null => false
    t.string   "validity",               :null => false
    t.string   "configured_by",          :null => false
    t.datetime "created_at",             :null => false
    t.datetime "updated_at"
  end

  add_index "online_themobilestore_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "online_tradus_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",           :null => false
    t.text     "product_image_url"
    t.string   "product_category",       :null => false
    t.string   "product_sub_category",   :null => false
    t.string   "product_identifier1",    :null => false
    t.string   "product_identifier2",    :null => false
    t.float    "product_price",          :null => false
    t.float    "product_shipping_cost",  :null => false
    t.string   "product_shipping_time",  :null => false
    t.string   "product_availability",   :null => false
    t.text     "product_redirect_url",   :null => false
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                 :null => false
    t.string   "validity",               :null => false
    t.string   "configured_by",          :null => false
    t.datetime "created_at",             :null => false
    t.datetime "updated_at"
  end

  add_index "online_tradus_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "online_univercell_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",           :null => false
    t.text     "product_image_url"
    t.string   "product_category",       :null => false
    t.string   "product_sub_category",   :null => false
    t.string   "product_identifier1",    :null => false
    t.string   "product_identifier2",    :null => false
    t.float    "product_price",          :null => false
    t.float    "product_shipping_cost",  :null => false
    t.string   "product_shipping_time",  :null => false
    t.string   "product_availability",   :null => false
    t.text     "product_redirect_url",   :null => false
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                 :null => false
    t.string   "validity",               :null => false
    t.string   "configured_by",          :null => false
    t.datetime "created_at",             :null => false
    t.datetime "updated_at"
  end

  add_index "online_univercell_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "online_uread_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",           :null => false
    t.text     "product_image_url"
    t.string   "product_category",       :null => false
    t.string   "product_sub_category",   :null => false
    t.string   "product_identifier1",    :null => false
    t.string   "product_identifier2",    :null => false
    t.float    "product_price",          :null => false
    t.float    "product_shipping_cost",  :null => false
    t.string   "product_shipping_time",  :null => false
    t.string   "product_availability",   :null => false
    t.text     "product_redirect_url",   :null => false
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                 :null => false
    t.string   "validity",               :null => false
    t.string   "configured_by",          :null => false
    t.datetime "created_at",             :null => false
    t.datetime "updated_at"
  end

  add_index "online_uread_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "online_zoomin_products", :primary_key => "product_id", :force => true do |t|
    t.string   "product_name",           :null => false
    t.text     "product_image_url"
    t.string   "product_category",       :null => false
    t.string   "product_sub_category",   :null => false
    t.string   "product_identifier1",    :null => false
    t.string   "product_identifier2",    :null => false
    t.float    "product_price",          :null => false
    t.float    "product_shipping_cost",  :null => false
    t.string   "product_shipping_time",  :null => false
    t.string   "product_availability",   :null => false
    t.text     "product_redirect_url",   :null => false
    t.text     "product_special_offers"
    t.text     "product_warranty"
    t.string   "reason",                 :null => false
    t.string   "validity",               :null => false
    t.string   "configured_by",          :null => false
    t.datetime "created_at",             :null => false
    t.datetime "updated_at"
  end

  add_index "online_zoomin_products", ["product_name", "product_identifier1", "product_identifier2"], :name => "product_name", :unique => true

  create_table "p1", :force => true do |t|
    t.string   "product_name", :null => false
    t.string   "url",          :null => false
    t.integer  "vendor_id",    :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at"
  end

  add_index "p1", ["url"], :name => "url", :unique => true

  create_table "patterns", :force => true do |t|
    t.integer  "vendor_id",               :null => false
    t.text     "pattern",                 :null => false
    t.string   "t_name",                  :null => false
    t.string   "b_type",    :limit => 10, :null => false
    t.datetime "u_at",                    :null => false
  end

  create_table "pendrives_f1_features", :primary_key => "feature_id", :force => true do |t|
    t.text     "feature_name", :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at"
  end

  create_table "pendrives_lists", :primary_key => "pendrives_list_id", :force => true do |t|
    t.string   "pendrive_name",                                            :null => false
    t.string   "pendrive_part_no",                                         :null => false
    t.text     "pendrive_image_url"
    t.string   "pendrive_brand",                                           :null => false
    t.string   "pendrive_type",                                            :null => false
    t.text     "pendrive_features",                                        :null => false
    t.string   "pendrive_availability_flag", :limit => 1, :default => "y", :null => false
    t.datetime "created_at",                                               :null => false
    t.datetime "updated_at"
    t.text     "name_slug"
    t.text     "identifier_slug"
  end

  add_index "pendrives_lists", ["pendrive_name", "pendrive_part_no"], :name => "name_id", :unique => true

  create_table "pendrives_rates", :force => true do |t|
    t.integer  "pendrives_list_id",         :limit => 8,                  :null => false
    t.text     "pendrive_price_source_url",                               :null => false
    t.float    "dp_tamilnadu"
    t.float    "mrp",                                    :default => 0.0
    t.datetime "created_at",                                              :null => false
    t.datetime "updated_at"
  end

  create_table "pendrives_vendor_f2_availabilities", :primary_key => "availability_id", :force => true do |t|
    t.string   "availability", :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at"
  end

  add_index "pendrives_vendor_f2_availabilities", ["availability"], :name => "availability", :unique => true

  create_table "populars", :force => true do |t|
    t.text     "name"
    t.string   "brand"
    t.string   "category"
    t.integer  "p_l_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "printers_f1_features", :primary_key => "feature_id", :force => true do |t|
    t.text     "feature_name", :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at"
  end

  create_table "printers_lists", :primary_key => "printers_list_id", :force => true do |t|
    t.string   "printer_name",                                            :null => false
    t.string   "printer_model_name",                                      :null => false
    t.text     "printer_image_url"
    t.string   "printer_brand",                                           :null => false
    t.string   "printer_type",                                            :null => false
    t.text     "printer_features",                                        :null => false
    t.string   "printer_availability_flag", :limit => 1, :default => "y", :null => false
    t.datetime "created_at",                                              :null => false
    t.datetime "updated_at"
    t.text     "name_slug"
    t.text     "identifier_slug"
  end

  add_index "printers_lists", ["printer_name", "printer_model_name"], :name => "name_id", :unique => true

  create_table "printers_rates", :force => true do |t|
    t.integer  "printers_list_id",         :limit => 8,                  :null => false
    t.text     "printer_price_source_url",                               :null => false
    t.float    "dp_tamilnadu"
    t.float    "mrp",                                   :default => 0.0
    t.datetime "created_at",                                             :null => false
    t.datetime "updated_at"
  end

  create_table "printers_vendor_f2_availabilities", :primary_key => "availability_id", :force => true do |t|
    t.string   "availability", :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at"
  end

  add_index "printers_vendor_f2_availabilities", ["availability"], :name => "availability", :unique => true

  create_table "priority_errors", :force => true do |t|
    t.string   "product_sub_category", :null => false
    t.string   "product_name",         :null => false
    t.string   "identifier1",          :null => false
    t.string   "identifier2",          :null => false
    t.text     "message"
    t.integer  "count"
    t.integer  "fixed",                :null => false
    t.datetime "created_at",           :null => false
    t.datetime "updated_at"
  end

  create_table "priority_requests", :primary_key => "request_id", :force => true do |t|
    t.text     "request",                          :null => false
    t.string   "request_type",                     :null => false
    t.integer  "merchants_list_id",                :null => false
    t.integer  "served",            :default => 0, :null => false
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at"
  end

  add_index "priority_requests", ["merchants_list_id"], :name => "merchants_list_id", :unique => true

  create_table "product_deals", :force => true do |t|
    t.integer  "vendor_id",                    :null => false
    t.integer  "sub_category_id",              :null => false
    t.integer  "product_id",      :limit => 8, :null => false
    t.integer  "unique_id",                    :null => false
    t.string   "business_type"
    t.text     "deal_info"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at"
  end

  create_table "product_purchase_commission_vendors", :force => true do |t|
    t.integer  "vendor_id",                          :null => false
    t.integer  "sub_category_id",                    :null => false
    t.float    "purchase_commission",                :null => false
    t.date     "subscribed_date",                    :null => false
    t.float    "cut_off_amount",                     :null => false
    t.integer  "cut_off_period",                     :null => false
    t.integer  "history_flag",        :default => 0, :null => false
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at"
  end

  add_index "product_purchase_commission_vendors", ["vendor_id", "sub_category_id"], :name => "vendor_id", :unique => true

  create_table "products_filter_collections", :primary_key => "filters_collection_id", :force => true do |t|
    t.string   "filter_key",          :null => false
    t.integer  "filter_id",           :null => false
    t.string   "filter_table_name",   :null => false
    t.string   "filter_table_column", :null => false
    t.integer  "sub_category_id",     :null => false
    t.datetime "created_at",          :null => false
    t.datetime "updated_at"
  end

  add_index "products_filter_collections", ["filter_key", "filter_id", "filter_table_name", "filter_table_column"], :name => "filter_key", :unique => true

  create_table "q", :id => false, :force => true do |t|
    t.integer "id"
  end

  create_table "qs", :id => false, :force => true do |t|
    t.integer "id"
  end

  create_table "routers_f1_features", :primary_key => "feature_id", :force => true do |t|
    t.text     "feature_name", :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at"
  end

  create_table "routers_lists", :primary_key => "routers_list_id", :force => true do |t|
    t.string   "router_name",                                            :null => false
    t.string   "router_part_no",                                         :null => false
    t.text     "router_image_url"
    t.string   "router_brand",                                           :null => false
    t.string   "router_type",                                            :null => false
    t.text     "router_features",                                        :null => false
    t.string   "router_availability_flag", :limit => 1, :default => "y", :null => false
    t.datetime "created_at",                                             :null => false
    t.datetime "updated_at"
    t.text     "name_slug"
    t.text     "identifier_slug"
  end

  add_index "routers_lists", ["router_name", "router_part_no"], :name => "name_id", :unique => true

  create_table "routers_rates", :force => true do |t|
    t.integer  "routers_list_id",         :limit => 8,                  :null => false
    t.text     "router_price_source_url",                               :null => false
    t.float    "dp_tamilnadu"
    t.float    "mrp",                                  :default => 0.0
    t.datetime "created_at",                                            :null => false
    t.datetime "updated_at"
  end

  create_table "routers_vendor_f2_availabilities", :primary_key => "availability_id", :force => true do |t|
    t.string   "availability", :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at"
  end

  add_index "routers_vendor_f2_availabilities", ["availability"], :name => "availability", :unique => true

  create_table "searches", :id => false, :force => true do |t|
    t.integer "id"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "sms", :primary_key => "sms_id", :force => true do |t|
    t.integer  "product_id",      :limit => 8,                   :null => false
    t.integer  "sub_category_id",                                :null => false
    t.integer  "vendor_id",                                      :null => false
    t.string   "landline_number",              :default => "NA"
    t.string   "mobile_number",                :default => "NA"
    t.datetime "created_at",                                     :null => false
    t.datetime "updated_at"
  end

  create_table "sms_details", :force => true do |t|
    t.integer  "sms_id",                                             :null => false
    t.string   "product_name",                                       :null => false
    t.string   "product_identifier2",              :default => "NA"
    t.string   "sub_category_name",                                  :null => false
    t.string   "vendor_name",                                        :null => false
    t.string   "vendor_city",                                        :null => false
    t.string   "vendor_branch",                                      :null => false
    t.string   "vendor_phone",                                       :null => false
    t.string   "user_mobile",                      :default => "NA"
    t.string   "user_landline",                    :default => "NA"
    t.string   "served_to_vendor",    :limit => 1, :default => "N"
    t.string   "served_to_user",      :limit => 1, :default => "N"
    t.datetime "created_at",                                         :null => false
    t.datetime "updated_at"
  end

  add_index "sms_details", ["sms_id"], :name => "sms_id", :unique => true

  create_table "speak_to_us", :force => true do |t|
    t.string   "name",                                             :null => false
    t.string   "email",                                            :null => false
    t.string   "contact_number",                                   :null => false
    t.text     "message"
    t.string   "advertisement_flag", :limit => 1, :default => "n"
    t.string   "query_flag",         :limit => 1, :default => "n"
    t.string   "suggestion_flag",    :limit => 1, :default => "n"
    t.string   "defect_flag",        :limit => 1, :default => "n"
    t.datetime "created_at",                                       :null => false
    t.datetime "updated_at"
  end

  create_table "speakers_f1_features", :primary_key => "feature_id", :force => true do |t|
    t.text     "feature_name", :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at"
  end

  create_table "speakers_lists", :primary_key => "speakers_list_id", :force => true do |t|
    t.string   "speaker_name",                                            :null => false
    t.string   "speaker_part_no",                                         :null => false
    t.text     "speaker_image_url"
    t.string   "speaker_brand",                                           :null => false
    t.string   "speaker_type",                                            :null => false
    t.text     "speaker_features",                                        :null => false
    t.string   "speaker_availability_flag", :limit => 1, :default => "y", :null => false
    t.datetime "created_at",                                              :null => false
    t.datetime "updated_at"
    t.text     "name_slug"
    t.text     "identifier_slug"
  end

  add_index "speakers_lists", ["speaker_name", "speaker_part_no"], :name => "name_id", :unique => true

  create_table "speakers_rates", :force => true do |t|
    t.integer  "speakers_list_id",         :limit => 8,                  :null => false
    t.text     "speaker_price_source_url",                               :null => false
    t.float    "dp_tamilnadu"
    t.float    "mrp",                                   :default => 0.0
    t.datetime "created_at",                                             :null => false
    t.datetime "updated_at"
  end

  create_table "speakers_vendor_f2_availabilities", :primary_key => "availability_id", :force => true do |t|
    t.string   "availability", :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at"
  end

  add_index "speakers_vendor_f2_availabilities", ["availability"], :name => "availability", :unique => true

  create_table "sponsored_seller_area_listings", :primary_key => "area_listings_id", :force => true do |t|
    t.integer  "city_id",          :null => false
    t.integer  "branch_id",        :null => false
    t.integer  "vendor_id",        :null => false
    t.integer  "mobile_brands_id", :null => false
    t.datetime "created_at",       :null => false
    t.datetime "updated_at"
  end

  add_index "sponsored_seller_area_listings", ["vendor_id", "branch_id", "mobile_brands_id", "city_id"], :name => "vendor_id", :unique => true

  create_table "sponsored_seller_city_listings", :primary_key => "city_listings_id", :force => true do |t|
    t.integer  "city_id",    :null => false
    t.integer  "vendor_id",  :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at"
  end

  add_index "sponsored_seller_city_listings", ["vendor_id", "city_id"], :name => "vendor_id", :unique => true

  create_table "stopwords", :primary_key => "stopword_id", :force => true do |t|
    t.string   "stopword",   :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at"
  end

  add_index "stopwords", ["stopword"], :name => "stopword", :unique => true

  create_table "strobs", :id => false, :force => true do |t|
    t.integer "id"
    t.integer "val"
    t.integer "a"
  end

  create_table "subcategories", :primary_key => "sub_category_id", :force => true do |t|
    t.string   "sub_category_name", :null => false
    t.integer  "category_id",       :null => false
    t.string   "category_name",     :null => false
    t.datetime "created_at",        :null => false
    t.datetime "updated_at"
    t.string   "img"
    t.string   "id_name"
    t.string   "brand"
    t.string   "name"
    t.string   "id1"
    t.string   "url"
    t.string   "avl"
    t.string   "ft"
    t.string   "avl_flag"
    t.text     "ft_disp"
    t.text     "p_step"
  end

  add_index "subcategories", ["category_name", "sub_category_name"], :name => "category_name", :unique => true

  create_table "t_view", :id => false, :force => true do |t|
    t.datetime "dt",                                           :null => false
    t.integer  "mobiles_list_id",  :limit => 8, :default => 0, :null => false
    t.text     "mobile_image_url"
    t.string   "mobile_name",                                  :null => false
    t.string   "mobile_brand",                                 :null => false
    t.string   "mobile_color",                                 :null => false
  end

  create_table "t_view_one", :id => false, :force => true do |t|
    t.datetime "dt",                                           :null => false
    t.integer  "mobiles_list_id",  :limit => 8, :default => 0, :null => false
    t.text     "mobile_image_url"
    t.string   "mobile_name",                                  :null => false
    t.string   "mobile_brand",                                 :null => false
    t.string   "mobile_color",                                 :null => false
  end

  create_table "tablets_f1_features", :primary_key => "feature_id", :force => true do |t|
    t.text     "feature_name", :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at"
  end

  create_table "tablets_lists", :primary_key => "tablets_list_id", :force => true do |t|
    t.string   "tablet_name",                                            :null => false
    t.string   "tablet_part_no",                                         :null => false
    t.text     "tablet_image_url"
    t.string   "tablet_brand",                                           :null => false
    t.string   "tablet_color",                                           :null => false
    t.text     "tablet_features",                                        :null => false
    t.string   "tablet_availability_flag", :limit => 1, :default => "y", :null => false
    t.datetime "created_at",                                             :null => false
    t.datetime "updated_at"
    t.text     "name_slug"
    t.text     "identifier_slug"
  end

  add_index "tablets_lists", ["tablet_name", "tablet_part_no"], :name => "name_id", :unique => true

  create_table "tablets_rates", :force => true do |t|
    t.integer  "tablets_list_id",         :limit => 8,                  :null => false
    t.text     "tablet_price_source_url",                               :null => false
    t.float    "dp_tamilnadu"
    t.float    "mrp",                                  :default => 0.0
    t.datetime "created_at",                                            :null => false
    t.datetime "updated_at"
  end

  create_table "tablets_vendor_f2_availabilities", :primary_key => "availability_id", :force => true do |t|
    t.string   "availability", :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at"
  end

  add_index "tablets_vendor_f2_availabilities", ["availability"], :name => "availability", :unique => true

  create_table "temp_desktops_rates", :force => true do |t|
    t.string   "desktop_part_no",                           :null => false
    t.text     "desktop_price_source_url",                  :null => false
    t.float    "dp_tamilnadu"
    t.float    "mrp",                      :default => 0.0
    t.datetime "created_at"
  end

  create_table "temp_external_hdds_rates", :force => true do |t|
    t.string   "external_hdd_part_no",                           :null => false
    t.text     "external_hdd_price_source_url",                  :null => false
    t.float    "dp_tamilnadu"
    t.float    "mrp",                           :default => 0.0
    t.datetime "created_at"
  end

  create_table "temp_headphones_rates", :force => true do |t|
    t.string   "headphone_part_no",                           :null => false
    t.text     "headphone_price_source_url",                  :null => false
    t.float    "dp_tamilnadu"
    t.float    "mrp",                        :default => 0.0
    t.datetime "created_at"
  end

  create_table "temp_headsets_rates", :force => true do |t|
    t.string   "headset_part_no",                           :null => false
    t.text     "headset_price_source_url",                  :null => false
    t.float    "dp_tamilnadu"
    t.float    "mrp",                      :default => 0.0
    t.datetime "created_at"
  end

  create_table "temp_keyboards_rates", :force => true do |t|
    t.string   "keyboard_part_no",                           :null => false
    t.text     "keyboard_price_source_url",                  :null => false
    t.float    "dp_tamilnadu"
    t.float    "mrp",                       :default => 0.0
    t.datetime "created_at"
  end

  create_table "temp_laptops_rates", :force => true do |t|
    t.string   "laptop_part_no",                           :null => false
    t.text     "laptop_price_source_url",                  :null => false
    t.float    "dp_tamilnadu"
    t.float    "mrp",                     :default => 0.0
    t.datetime "created_at"
  end

  create_table "temp_memory_cards_rates", :force => true do |t|
    t.string   "memory_card_part_no",                           :null => false
    t.text     "memory_card_price_source_url",                  :null => false
    t.float    "dp_tamilnadu"
    t.float    "mrp",                          :default => 0.0
    t.datetime "created_at"
  end

  create_table "temp_merchant_logs", :primary_key => "log_id", :force => true do |t|
    t.integer  "merchant_id", :null => false
    t.integer  "vendor_id",   :null => false
    t.string   "login_name",  :null => false
    t.datetime "login_time",  :null => false
    t.datetime "logout_time", :null => false
    t.date     "log_date",    :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at"
  end

  create_table "temp_mouses_rates", :force => true do |t|
    t.string   "mouse_part_no",                           :null => false
    t.text     "mouse_price_source_url",                  :null => false
    t.float    "dp_tamilnadu"
    t.float    "mrp",                    :default => 0.0
    t.datetime "created_at"
  end

  create_table "temp_nearby_2kms_branches", :force => true do |t|
    t.string   "city_name",   :null => false
    t.string   "branch_name", :null => false
    t.string   "area",        :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at"
  end

  create_table "temp_nearby_4kms_branches", :force => true do |t|
    t.string   "city_name",   :null => false
    t.string   "branch_name", :null => false
    t.string   "area",        :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at"
  end

  create_table "temp_nearby_6kms_branches", :force => true do |t|
    t.string   "city_name",   :null => false
    t.string   "branch_name", :null => false
    t.string   "area",        :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at"
  end

  create_table "temp_pendrives_rates", :force => true do |t|
    t.string   "pendrive_part_no",                           :null => false
    t.text     "pendrive_price_source_url",                  :null => false
    t.float    "dp_tamilnadu"
    t.float    "mrp",                       :default => 0.0
    t.datetime "created_at"
  end

  create_table "temp_printers_rates", :force => true do |t|
    t.string   "printer_model_name",                        :null => false
    t.text     "printer_price_source_url",                  :null => false
    t.float    "dp_tamilnadu"
    t.float    "mrp",                      :default => 0.0
    t.datetime "created_at"
  end

  create_table "temp_routers_rates", :force => true do |t|
    t.string   "router_part_no",                           :null => false
    t.text     "router_price_source_url",                  :null => false
    t.float    "dp_tamilnadu"
    t.float    "mrp",                     :default => 0.0
    t.datetime "created_at"
  end

  create_table "temp_searchkey_logs", :primary_key => "log_id", :force => true do |t|
    t.string   "search_keys",  :limit => 500, :null => false
    t.string   "landing_page",                :null => false
    t.date     "log_date",                    :null => false
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at"
  end

  create_table "temp_speakers_rates", :force => true do |t|
    t.string   "speaker_part_no",                           :null => false
    t.text     "speaker_price_source_url",                  :null => false
    t.float    "dp_tamilnadu"
    t.float    "mrp",                      :default => 0.0
    t.datetime "created_at"
  end

  create_table "temp_tablets_rates", :force => true do |t|
    t.string   "tablet_part_no",                           :null => false
    t.text     "tablet_price_source_url",                  :null => false
    t.float    "dp_tamilnadu"
    t.float    "mrp",                     :default => 0.0
    t.datetime "created_at"
  end

  create_table "temp_transactions_logs", :primary_key => "log_id", :force => true do |t|
    t.integer  "unique_id",                   :null => false
    t.string   "user_keyword", :limit => 500
    t.string   "type",                        :null => false
    t.date     "log_date",                    :null => false
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at"
  end

  create_table "tests", :id => false, :force => true do |t|
    t.integer "id"
    t.integer "val"
  end

  create_table "variable_pay_vendors", :force => true do |t|
    t.integer  "vendor_id",                                 :null => false
    t.float    "accepted_impressions_rate",                 :null => false
    t.float    "accepted_button_click_rate",                :null => false
    t.date     "subscribed_date",                           :null => false
    t.float    "cut_off_amount",                            :null => false
    t.integer  "cut_off_period",                            :null => false
    t.integer  "history_flag",               :default => 0, :null => false
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at"
  end

  add_index "variable_pay_vendors", ["vendor_id"], :name => "vendor_id", :unique => true

  create_table "vendor_coupons", :primary_key => "coupon_id", :force => true do |t|
    t.integer  "unique_id",             :limit => 8, :null => false
    t.integer  "vendor_id",                          :null => false
    t.string   "coupon_code",                        :null => false
    t.string   "customer_phone_number"
    t.integer  "sub_category_id"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at"
    t.integer  "c_id"
  end

  add_index "vendor_coupons", ["vendor_id", "coupon_code"], :name => "vendor_id", :unique => true

  create_table "vendor_coupons_details", :force => true do |t|
    t.integer  "coupon_id",             :limit => 8, :null => false
    t.string   "coupon_code",                        :null => false
    t.string   "sub_category_name",                  :null => false
    t.string   "product_name",                       :null => false
    t.string   "product_identifier2"
    t.string   "vendor_name",                        :null => false
    t.string   "vendor_branch_name",                 :null => false
    t.string   "vendor_city_name",                   :null => false
    t.string   "vendor_phone_number"
    t.string   "customer_phone_number"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at"
  end

  create_table "vendor_data_priorities", :force => true do |t|
    t.string   "vendor_table_name",    :null => false
    t.string   "product_name",         :null => false
    t.string   "product_identifier1",  :null => false
    t.string   "product_identifier2",  :null => false
    t.integer  "priority_errors_flag", :null => false
    t.datetime "created_at",           :null => false
    t.datetime "updated_at"
  end

  create_table "vendor_deals", :force => true do |t|
    t.string   "sub_category",  :null => false
    t.string   "product_name",  :null => false
    t.string   "identifier1"
    t.string   "identifier2"
    t.string   "vendor_name",   :null => false
    t.string   "business_type", :null => false
    t.string   "city_name",     :null => false
    t.string   "branch_name",   :null => false
    t.text     "deal_info"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at"
  end

  create_table "vendor_product_purchases_logs", :primary_key => "v_p_purch_log_id", :force => true do |t|
    t.integer  "vendor_id",                            :null => false
    t.integer  "sub_category_id",                      :null => false
    t.integer  "product_id",              :limit => 8, :null => false
    t.integer  "product_purchase_count",               :null => false
    t.float    "product_purchase_amount",              :null => false
    t.date     "log_date",                             :null => false
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at"
  end

  create_table "vendor_product_transactions_logs", :primary_key => "v_p_trans_log_id", :force => true do |t|
    t.integer  "vendor_id",                           :null => false
    t.integer  "sub_category_id",                     :null => false
    t.integer  "product_id",             :limit => 8, :null => false
    t.integer  "page_impressions_count",              :null => false
    t.integer  "button_clicks_count",                 :null => false
    t.date     "log_date",                            :null => false
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at"
  end

  create_table "vendors_config_logs", :primary_key => "log_id", :force => true do |t|
    t.string   "configured_by",                :null => false
    t.string   "reason",                       :null => false
    t.string   "validity",                     :null => false
    t.integer  "product_id",      :limit => 8, :null => false
    t.integer  "vendor_id",                    :null => false
    t.integer  "sub_category_id",              :null => false
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at"
  end

  create_table "vendors_details", :force => true do |t|
    t.integer  "vendor_id",                                   :null => false
    t.string   "vendor_name"
    t.string   "vendor_phone"
    t.string   "vendor_city"
    t.string   "vendor_branch"
    t.string   "vendor_contact_name", :default => "Merchant"
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at"
  end

  add_index "vendors_details", ["vendor_id", "vendor_phone"], :name => "vendor_id", :unique => true

  create_table "vendors_lists", :primary_key => "vendor_id", :force => true do |t|
    t.string   "vendor_name",                                               :null => false
    t.string   "vendor_alias_name"
    t.text     "vendor_logo",                                               :null => false
    t.text     "vendor_description",                                        :null => false
    t.string   "business_type",                                             :null => false
    t.string   "vendor_website",                          :default => "na"
    t.string   "vendor_email",                            :default => "na"
    t.string   "vendor_phone",                                              :null => false
    t.string   "vendor_fax",                              :default => "na"
    t.text     "vendor_address",                                            :null => false
    t.string   "latitude",                                :default => "na"
    t.string   "longitude",                               :default => "na"
    t.string   "city_name",                                                 :null => false
    t.string   "branch_name",                                               :null => false
    t.string   "branch_alias_name"
    t.text     "working_time"
    t.text     "miscellaneous"
    t.string   "vendor_speciality_store",                 :default => "na"
    t.string   "established_year",                        :default => "na"
    t.string   "vendor_sub_categories",   :limit => 500,                    :null => false
    t.string   "affiliate_id",            :limit => 100,  :default => "0"
    t.string   "monetization_type",                                         :null => false
    t.date     "subscribed_date",                                           :null => false
    t.string   "trial_flag",              :limit => 1,    :default => "n"
    t.integer  "vendor_rating",                           :default => 0
    t.integer  "blocked_flag",                            :default => 0
    t.integer  "discarded_flag",                          :default => 0
    t.string   "sponsored_seller_flag",   :limit => 1,    :default => "n"
    t.string   "freeze_flag",             :limit => 1,    :default => "n"
    t.datetime "created_at",                                                :null => false
    t.datetime "updated_at"
    t.integer  "top",                                     :default => 0
    t.string   "cat_bran",                :limit => 1000
    t.integer  "admin",                                                     :null => false
    t.integer  "premium",                                 :default => 0
    t.integer  "authorised",                              :default => 0
    t.integer  "cards",                                   :default => 0
    t.integer  "affiliate",                               :default => 0
    t.text     "brands"
    t.string   "enquiry_no",              :limit => 15
    t.string   "landmark"
    t.string   "owner"
    t.string   "poc"
  end

  add_index "vendors_lists", ["vendor_name", "business_type", "city_name", "branch_name"], :name => "vendor_name", :unique => true

  create_table "vendors_ratings", :primary_key => "rating_id", :force => true do |t|
    t.integer  "vendor_id",   :limit => 8, :null => false
    t.integer  "ratings"
    t.text     "reviews"
    t.integer  "customer_id", :limit => 8, :null => false
    t.datetime "created_at",               :null => false
    t.datetime "updated_at"
  end

  create_table "z", :id => false, :force => true do |t|
    t.string "a"
  end

end
