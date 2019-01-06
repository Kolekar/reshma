  class ReportsController < ApplicationController
  layout 'report'
  before_action :authenticate_dairy!

  def member
    if params[:user_id].present?
      @collections = current_dairy.collections.where(user_id = params[:user_id])
      params[:from_date] = params[:from_date] ? Date.parse(params[:from_date]) : (Date.today - 6.day)
      params[:to_date] = params[:to_date] ? Date.parse(params[:to_date]) : Date.today
      @collections = @collections.collection_between(params[:from_date], params[:to_date])
      if params[:time] == 'true'
        @collections = @collections.morning
      elsif params[:time] == 'false'
        @collections = @collections.evening
      end

      if params[:animal_type] == 'true'
        @collections = @collections.cow
      elsif params[:animal_type] == 'false'
        @collections = @collections.buffalo
      end
      @collections = @collections.includes(:user)
    else
      @collections = []
    end
  end

  def daily
    params[:collection_date] = params[:collection_date] ? Date.parse(params[:collection_date]) : Date.today
    @collections = current_dairy.collections.collection_at(params[:collection_date])
    if params[:time] == 'true'
      @collections = @collections.morning
    elsif params[:time] == 'false'
      @collections = @collections.evening
    end

    if params[:animal_type] == 'true'
      @collections = @collections.cow
    elsif params[:animal_type] == 'false'
      @collections = @collections.buffalo
    end
  end

  def dairy
    params[:from_date] = params[:from_date] ? Date.parse(params[:from_date]) : (Date.today - 6.day)
    params[:to_date] = params[:to_date] ? Date.parse(params[:to_date]) : Date.today
    @collections = current_dairy.collections.collection_between(params[:from_date], params[:to_date])
    if params[:time] == 'true'
      @collections = @collections.morning
    elsif params[:time] == 'false'
      @collections = @collections.evening
    end

    if params[:animal_type] == 'true'
      @collections = @collections.cow
    elsif params[:animal_type] == 'false'
      @collections = @collections.buffalo
    end
    @collections = @collections.group(:collection_date, :animal_type, :time).select('SUM(collections.litre) as litres, SUM(collections.rate*collections.litre) as total, collection_date, animal_type, time')
  end

  def all_member
    params[:from_date] = params[:from_date] ? Date.parse(params[:from_date]) : (Date.today - 6.day)
    params[:to_date] = params[:to_date] ? Date.parse(params[:to_date]) : Date.today
    @collections = current_dairy.collections.collection_between(params[:from_date], params[:to_date])
    if params[:time] == 'true'
      @collections = @collections.morning
    elsif params[:time] == 'false'
      @collections = @collections.evening
    end

    if params[:animal_type] == 'true'
      @collections = @collections.cow
    elsif params[:animal_type] == 'false'
      @collections = @collections.buffalo
    end
    @collections = @collections.group(:user_id, :animal_type, :time).select('SUM(collections.litre) as litres, SUM(collections.rate*collections.litre) as total, collection_date, animal_type, time, user_id')
    @collections = @collections.includes(:user)
  end

  def user
    @users = current_dairy.users.all
    if params[:animal_type] == 'true'
      @users = @users.cow
    elsif params[:animal_type] == 'false'
      @users = @users.buffalo
    end
  end
end
