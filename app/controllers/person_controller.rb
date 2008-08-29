#----------------------------------------------------------------------
# Authors:
#   Bruno Dilly
#
# Copyright (C) 2007 Authors
#
# Released under GNU GPL, read the file 'COPYING' for more information
# ---------------------------------------------------------------------
class PersonController < ApplicationController

  before_filter :authorize, :except => [:sign_up, :login, :index]

  layout "main"

  def index
  end

  def sign_up
    @person = Person.new(params[:person])
    if request.post? and @person.save
      flash[:notice] = "#{@person.full_name}, your account was succefully created"
      redirect_to(:action => "index")
    end
  end

  def login
    session[:person_id] = nil
    if request.post?
      person = Person.authenticate(params[:name], params[:password])
      if person
        session[:person_id] = person.id
        uri = session[:original_uri]
        session[:original_uri] = nil
        redirect_to(uri || :action => "index")
      else
        flash[:notice] = "Sorry, your login was incorrect."
      end
    end
  end

  def logout
    session[:person_id] = nil
    flash[:notice] = "Logged out"
    redirect_to(:action => "index")
  end

end
