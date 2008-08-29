#----------------------------------------------------------------------
# Authors:
#   Bruno Dilly
#
# Copyright (C) 2007 Authors
#
# Released under GNU GPL, read the file 'COPYING' for more information
# ---------------------------------------------------------------------
class CreateBills < ActiveRecord::Migration
  def self.up
    create_table :bills do |t|
      t.column :group_id, :integer, :null => false
      t.column :person_id, :integer, :null => false
      t.column :name, :string, :null => false
      t.column :date, :timestamp, :null => false
      t.column :total_due, :float, :null => false
      t.column :description, :text
      t.column :created_at, :timestamp
    end

    execute "alter table bills add constraint fk_bill_groups
              foreign key (group_id) references groups(id)"

    execute "alter table bills add constraint fk_bill_people
              foreign key (person_id) references people(id)"

  end

  def self.down
    execute 'ALTER TABLE bills DROP FOREIGN KEY fk_bill_groups'
    execute 'ALTER TABLE bills DROP FOREIGN KEY fk_bill_people'
    drop_table :bills
  end
end
