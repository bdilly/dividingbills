#----------------------------------------------------------------------
# Authors:
#   Bruno Dilly
#
# Copyright (C) 2007 Authors
#
# Released under GNU GPL, read the file 'COPYING' for more information
# ---------------------------------------------------------------------
class Share < ActiveRecord::Base
  belongs_to :person
  belongs_to :bill

  validates_presence_of :value
  validates_numericality_of :value
  validates_presence_of :who_I_should_pay_to
  validates_presence_of :who_I_paid_to
  
end
