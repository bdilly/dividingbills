#----------------------------------------------------------------------
# Authors:
#   Bruno Dilly
#
# Copyright (C) 2007 Authors
#
# Released under GNU GPL, read the file 'COPYING' for more information
# ---------------------------------------------------------------------
class BillController < ApplicationController

  before_filter :authorize

  layout "main"

  def create
    @bill = Bill.new(params[:bill])
    if request.post? 
      @bill.person_id = session[:person_id]
      if @bill.save
        people = Group.find(@bill.group_id).members.find(:all)
        value = @bill.total_due / people.length
        for person in people
          @share = Share.new
          @share.person_id = person.id
          @share.bill_id = @bill.id
          @share.value = value
          @share.who_I_should_pay_to = Person.find(@bill.person_id).name
          @share.who_I_paid_to = "Nobody"
          @share.save
        end
        flash[:notice] = "Bill #{@bill.name} was created"
        @bill = Bill.new
      end
    end
  end

  def view
  end

  def shares_to_pay
    if person = Person.find_by_id(session[:person_id])
      @my_shares_pages, @my_shares = paginate :shares, :conditions => ["person_id = ? and I_paid = ?", session[:person_id], false], :per_page => 10
    else
      redirect_to(:controller => :person, :action => :login)
    end
  end

  def paid_shares_to_confirm
    if person = Person.find_by_id(session[:person_id])
      @my_shares_pages, @my_shares = paginate :shares, :conditions => ["who_I_should_pay_to = ? and I_paid = ? and she_paid = ?", person.name, true, false], :per_page => 10
    else
      redirect_to(:controller => :person, :action => :login)
    end
  end

  def confirm_share_was_paid
    @share = Share.find(params[:id])
    person = Person.find_by_id(session[:person_id])
    if person.name == @share.who_I_paid_to
      if request.post?
        @share = Share.find(params[:id])
        @share.update_attributes(:she_paid => true, :she_paid_at => Time.now)
        flash[:notice] = "Confirmed"
      end
    end
    redirect_to(:action => :paid_shares_to_confirm)
  end


  def pay_share
    @share = Share.find(params[:id])
    @people = Group.find(Bill.find(@share.bill_id).group_id).members.find(:all)
    if (session[:person_id] == @share.person_id) and request.post?
      @share.update_attributes(params[:share])
      @share.I_paid_at = Time.now
      @share.I_paid = true
      if @share.save
        flash[:notice] = "The share was paid"
        redirect_to(:action => :shares_to_pay)
      end
    end
  end

  def pay_share_for_somebody_else
    @share = Share.find(params[:id])
    persona = Person.find_by_id(@share.person_id)
    bill_id = @share.bill_id
    value = @share.value
    if person = Person.find_by_id(session[:person_id])
      @share.who_I_paid_to = person.name
      @share.I_paid_at = Time.now
      @share.I_paid = true
      if @share.save
        @share = Share.new
        @share.person_id = persona.id
        @share.bill_id = bill_id
        @share.value = value
        @share.who_I_should_pay_to = person.name
        @share.who_I_paid_to = "Nobody"
        if @share.save
          flash[:notice] = "The share was paid"
          redirect_to(:action => :list_my_shares)
        end
      end
    else
      redirect_to(:controller => :person, :action => :login)
    end
  end

  def list_my_bills
    if person = Person.find_by_id(session[:person_id])
      @my_bills_pages, @my_bills = paginate :bills, :conditions => ["person_id = ?", session[:person_id]], :order => "created_at DESC", :per_page => 10
    else
      redirect_to(:controller => :person, :action => :login)
    end
  end

  def list_my_shares
    if person = Person.find_by_id(session[:person_id])
      @my_shares_pages, @my_shares = paginate :shares, :conditions => ["person_id = ?", session[:person_id]], :order => "created_at DESC", :per_page => 10
    else
      redirect_to(:controller => :person, :action => :login)
    end
  end

end
