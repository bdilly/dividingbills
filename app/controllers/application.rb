#----------------------------------------------------------------------
# Authors:
#   Bruno Dilly
#
# Copyright (C) 2007 Authors
#
# Released under GNU GPL, read the file 'COPYING' for more information
# ---------------------------------------------------------------------
# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  # Pick a unique cookie name to distinguish our session data from others'
  session :session_key => '_dividingbills_session_id'

  private

  def authorize
    unless Person.find_by_id(session[:person_id])
      redirect_to(:controller => "person", :action => "login")
    end
  end

end
