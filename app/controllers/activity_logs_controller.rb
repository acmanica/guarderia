class ActivityLogsController < ApplicationController
  before_action :set_params 
  
  def index

  @babies = Baby.all.order('name ASC')
  @assistants = Assistant.all.order('name ASC')

  @list = ActivityLog.all.order('start_time DESC')
  @list = ActivityLog.where(baby_id: @baby_id).order('start_time DESC') if  @baby_id.present?
  @list = ActivityLog.where(assistant_id: @assistant_id).order('start_time DESC') if @assistant_id.present?
  @list = ActivityLog.where('baby_id = ? AND assistant_id = ?', @baby_id, @assistant_id ).order('start_time DESC') if @assistant_id.present? and @baby_id.present?

  @list = @list.where('duration IS NOT NULL') if @status == 2.to_s
  @list = @list.where('duration IS NULL') if @status == 3.to_s
  
  @list = @list.paginate(page: params[:page], per_page: 50)
  end

  private
  def set_params
    @baby_id = params["baby_id"]
    @assistant_id = params["assistant_id"]
    @status = params["status"]
  end
end
