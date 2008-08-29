#----------------------------------------------------------------------
# Authors:
#   Bruno Dilly
#
# Copyright (C) 2007 Authors
#
# Released under GNU GPL, read the file 'COPYING' for more information
# ---------------------------------------------------------------------
class Bill < ActiveRecord::Base
  belongs_to :group
  belongs_to :person
  has_many :shares

  validates_presence_of :group_id
  validates_presence_of :person_id
  validates_presence_of :name
  validates_presence_of :date
  validates_presence_of :total_due
  validates_numericality_of :total_due
end
