#----------------------------------------------------------------------
# Authors:
#   Bruno Dilly
#
# Copyright (C) 2007 Authors
#
# Released under GNU GPL, read the file 'COPYING' for more information
# ---------------------------------------------------------------------
class GroupController < ApplicationController

  before_filter :authorize, :except => :list_groups

  layout "main"

  def create
    @group = Group.new(params[:group])
    @group.members << Person.find_by_id(session[:person_id])
    if request.post? and @group.save
      flash.now[:notice] = "Group #{@group.name} created"
      @group = Group.new
    end
  end

  def join
    if person = Person.find_by_id(session[:person_id])
      if request.post?
        begin
          @group = Group.find(params[:id])
        rescue ActiveRecord::RecordNotFound
          logger.error("#{person.id} attempt to join invalid group #{params[:id]}")
          redirect_to_index("Invalid group")
        else
          @group.members << person
          flash[:notice] = "You've joined #{@group.name}"
        end
      end
    end
    redirect_to(:action => :list_groups)
  end

  def list_groups
    @all_group_pages, @all_groups = paginate :groups, :order => "name", :per_page => 10
  end

  def list_group_members
    begin
      @group =  Group.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      logger.error("Attempt to list member of invalid group #{params[:id]}")
      redirect_to_index("Invalid group")
    else
      group_members =  @group.members.find(:all, :order => "name")
      @all_group_members = group_members
    end
  end

  def list_group_bills
    begin
      @group =  Group.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      logger.error("Attempt to list bills of invalid group #{params[:id]}")
      redirect_to_index("Invalid group")
    else
      @group_bills_pages, @group_bills = paginate :bills, :conditions => ["group_id = ?", params[:id]], :order => "created_at DESC", :per_page => 10
    end
  end

  private
  
  def redirect_to_index(msg=nil)
    flash[:notice] = msg if msg
    redirect_to :action => :list_groups  
  end

end
