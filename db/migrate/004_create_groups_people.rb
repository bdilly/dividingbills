#----------------------------------------------------------------------
# Authors:
#   Bruno Dilly
#
# Copyright (C) 2007 Authors
#
# Released under GNU GPL, read the file 'COPYING' for more information
# ---------------------------------------------------------------------
class CreateGroupsPeople < ActiveRecord::Migration
  def self.up
    create_table :groups_people, :id => false do |t|
      t.column :group_id, :integer, :null => false
      t.column :person_id, :integer, :null => false
    end
    add_index :groups_people, [:group_id]
    add_index :groups_people, [:person_id]
  end

  def self.down
    drop_table :groups_people
  end
end
