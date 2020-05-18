module Api
  class ActivitiesController < ApplicationController
    skip_before_action :verify_authenticity_token
    skip_before_action :authenticate_user!

    def index
      activities = Activity.order('created_at DESC').paginate(page: page, per_page: per_page)
      data = activities.map { |row| {id: row.id, name: row.name, description: row.description} }
      render json: {status: 'SUCCESS', message: 'Loaded activities', data: data }, status: :ok
    end

    def create
      activity = Activity.new(activity_log_params)
      if activity.save
        render json: {status: 'SUCCESS', message: 'Saved Activity', data: activity }, status: :ok
      else
        render json: {status: 'ERROR', message: 'Arctivity not saved', data: activity.errors}, status: :unprocessable_entity
      end
    end

    def show
      activity = Activity.find(params[:id])
      render json: {status: 'SUCCESS', message: 'Activity Loaded', data: activity }, status: :ok
    end

    def destroy
      activity = Activity.find(params[:id])
      activity.destroy
      render json: {status: 'SUCCESS', message: 'Deleted Activity', data: activity }, status: :ok
    end

    def update
      activity = Activity.find(params[:id])
      if activity.update_attributes(activity_log_params)
        render json: {status: 'SUCCESS', message: 'Updated Activity', data: activity }, status: :ok
      else
        render json: {status: 'ERROR', message: '  Arctivity not updated', data: activity.errors}, status: :unprocessable_entity
      end
    end

    private
    def activity_log_params
      params.permit( :name, :description )
    end


    def page
      @page ||= params[:page] || 1
    end
    
    def per_page
      @per_page ||= params[:per_page] || 5
    end  

  end
end  