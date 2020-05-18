module Api
  class ActivityLogsController < ApplicationController
    skip_before_action :verify_authenticity_token
    skip_before_action :authenticate_user!
    def index
      activities = ActivityLog.where(baby_id: params[:baby_id]).paginate(page: page, per_page: per_page)
      activities = activities.map do |row| 
        {id: row.id, 
         baby_id: row.baby_id,
         assistant_name: row.assistant.name, 
         start_time: row.start_time.to_s(:utc_datetime), 
         stop_time: row.stop_time.nil? ? "not finished" : row.stop_time.to_s(:utc_datetime)
       }
      end
      if !activities.blank?
        render json: {status: 'SUCCESS', message: 'Activities founded', data: activities }, status: :ok
      else
        render json: {status: 'ERROR', message: '  Arctivities not founded'}, status: :unprocessable_entity
      end  
    end

    def create
      @activity_log = ActivityLog.new(activity_log_params)
      if @activity_log.save
        render json: {status: 'SUCCESS', message: 'Saved Activity', data: @activity_log }, status: :ok
      else
        render json: {status: 'ERROR', message: 'Arctivity not saved', data: @activity_log.errors}, status: :unprocessable_entity
      end
    end

    def show
      @activity_log = ActivityLog.find(params[:id])
      render json: {status: 'SUCCESS', message: 'Activity Loaded', data: @activity_log }, status: :ok
    end

    def destroy
      @activity_log = ActivityLog.find(params[:id])
      @activity_log.destroy
      render json: {status: 'SUCCESS', message: 'Deleted Activity', data: @activity_log }, status: :ok
    end

    def update
      @activity_log = ActivityLog.find(params[:id])
      set_duration
      if @activity_log.update_attributes(activity_log_params)
        render json: {status: 'SUCCESS', message: 'Updated Activity', data: @activity_log }, status: :ok
      else
        render json: {status: 'ERROR', message: '  Arctivity not updated', data: @activity_log.errors}, status: :unprocessable_entity
      end
    end

    private
    def activity_log_params
      params.permit( :assistant_id, :activity_id, :baby_id, :start_time , :stop_time, :comments )
    end

    def set_duration
      @activity_log.stop_time =  Time.now
      duration = ( @activity_log.stop_time - @activity_log.start_time) / 1.minutes
       @activity_log.duration =  duration
    end  

    def page
      @page ||= params[:page] || 1
    end
    
    def per_page
      @per_page ||= params[:per_page] || 5
    end  
  end
end