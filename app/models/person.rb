#----------------------------------------------------------------------
# Authors:
#   Bruno Dilly
#
# Copyright (C) 2007 Authors
#
# Released under GNU GPL, read the file 'COPYING' for more information
# ---------------------------------------------------------------------
require 'digest/sha1'

class Person < ActiveRecord::Base
  has_and_belongs_to_many :my_groups, :class_name => "Group",
    :association_foreign_key => "group_id", :join_table => "groups_people"
  has_many :shares
  has_many :bills
  validates_presence_of :name
  validates_uniqueness_of :name
  validates_presence_of :e_mail
  validates_uniqueness_of :e_mail

  attr_accessor :password_confirmation
  validates_confirmation_of :password

  def validate
    errors.add_to_base("Missing Password") if hashed_password.blank?
  end

  def self.authenticate(name, password)
    person = self.find_by_name(name)
    if person
      expected_password = encrypted_password(password, person.salt)
      if person.hashed_password != expected_password
        person = nil
      end
    end
    person
  end

  def password
    @password
  end

  def password=(pwd)
    @password = pwd
    return if pwd.blank?
    create_new_salt
    self.hashed_password = Person.encrypted_password(self.password, self.salt)
  end

  private

  def self.encrypted_password(password, salt)
    string_to_hash = password + "tijolo22" + salt
    Digest::SHA1.hexdigest(string_to_hash)
  end

  def create_new_salt
    self.salt = self.object_id.to_s + rand.to_s
  end
end

