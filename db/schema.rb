# This file is autogenerated. Instead of editing this file, please use the
# migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.

ActiveRecord::Schema.define(:version => 6) do

  create_table "bills", :force => true do |t|
    t.column "group_id",    :integer,                  :null => false
    t.column "person_id",   :integer,                  :null => false
    t.column "name",        :string,   :default => "", :null => false
    t.column "date",        :datetime,                 :null => false
    t.column "total_due",   :float,                    :null => false
    t.column "description", :text
    t.column "created_at",  :datetime
  end

  add_index "bills", ["group_id"], :name => "fk_bill_groups"
  add_index "bills", ["person_id"], :name => "fk_bill_people"

  create_table "groups", :force => true do |t|
    t.column "name",        :string,   :default => "", :null => false
    t.column "description", :string
    t.column "created_at",  :datetime
  end

  create_table "groups_people", :id => false, :force => true do |t|
    t.column "group_id",  :integer, :null => false
    t.column "person_id", :integer, :null => false
  end

  add_index "groups_people", ["group_id"], :name => "index_groups_people_on_group_id"
  add_index "groups_people", ["person_id"], :name => "index_groups_people_on_person_id"

  create_table "people", :force => true do |t|
    t.column "name",            :string,   :default => "",     :null => false
    t.column "hashed_password", :string,   :default => "",     :null => false
    t.column "salt",            :string,   :default => "",     :null => false
    t.column "full_name",       :string
    t.column "e_mail",          :string,   :default => "",     :null => false
    t.column "user_group",      :string,   :default => "user"
    t.column "deleted",         :boolean,  :default => false
    t.column "created_at",      :datetime
  end

  create_table "sessions", :force => true do |t|
    t.column "session_id", :string
    t.column "data",       :text
    t.column "updated_at", :datetime
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "shares", :force => true do |t|
    t.column "person_id",           :integer,                     :null => false
    t.column "bill_id",             :integer,                     :null => false
    t.column "value",               :float,                       :null => false
    t.column "who_I_should_pay_to", :string,   :default => "",    :null => false
    t.column "who_I_paid_to",       :string
    t.column "I_paid",              :boolean,  :default => false
    t.column "she_paid",            :boolean,  :default => false
    t.column "I_paid_at",           :datetime
    t.column "she_paid_at",         :datetime
    t.column "created_at",          :datetime
  end

  add_index "shares", ["person_id"], :name => "fk_share_people"
  add_index "shares", ["bill_id"], :name => "fk_share_bills"

end