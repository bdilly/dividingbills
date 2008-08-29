#----------------------------------------------------------------------
# Authors:
#   Bruno Dilly
#
# Copyright (C) 2007 Authors
#
# Released under GNU GPL, read the file 'COPYING' for more information
# ---------------------------------------------------------------------
class Group < ActiveRecord::Base
  has_and_belongs_to_many :members,
    :class_name => "Person", :association_foreign_key => "person_id",
    :join_table => "groups_people" 
  has_many :bills
  
  validates_presence_of :name
  validates_uniqueness_of :name
end
