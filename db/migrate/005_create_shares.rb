#----------------------------------------------------------------------
# Authors:
#   Bruno Dilly
#
# Copyright (C) 2007 Authors
#
# Released under GNU GPL, read the file 'COPYING' for more information
# ---------------------------------------------------------------------
class CreateShares < ActiveRecord::Migration
  def self.up
    create_table :shares do |t|
      t.column :person_id, :integer, :null => false
      t.column :bill_id, :integer, :null => false
      t.column :value, :float, :null => false
      t.column :who_I_should_pay_to, :string, :null => false
      t.column :who_I_paid_to, :string, :null => false
      t.column :I_paid, :boolean, :default => false
      t.column :she_paid, :boolean, :default => false
      t.column :I_paid_at, :timestamp
      t.column :she_paid_at, :timestamp
      t.column :created_at, :timestamp
    end

    execute "alter table shares add constraint fk_share_people
              foreign key (person_id) references people(id)"

    execute "alter table shares add constraint fk_share_bills
              foreign key (bill_id) references bills(id)"

  end

  def self.down
    execute 'ALTER TABLE shares DROP FOREIGN KEY fk_share_people'
    execute 'ALTER TABLE shares DROP FOREIGN KEY fk_share_bills'
    drop_table :shares
  end
end
