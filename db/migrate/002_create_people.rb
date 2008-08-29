#----------------------------------------------------------------------
# Authors:
#   Bruno Dilly
#
# Copyright (C) 2007 Authors
#
# Released under GNU GPL, read the file 'COPYING' for more information
# ---------------------------------------------------------------------
class CreatePeople < ActiveRecord::Migration
  def self.up
    create_table :people do |t|
      t.column :name, :string, :null => false
      t.column :hashed_password, :string, :null => false
      t.column :salt, :string, :null => false
      t.column :full_name, :string
      t.column :e_mail, :string, :null => false
      t.column :user_group, :string, :default => "user"
      t.column :deleted, :boolean, :default => false
      t.column :created_at, :timestamp
    end  
  end

  def self.down
    drop_table :people
  end
end
