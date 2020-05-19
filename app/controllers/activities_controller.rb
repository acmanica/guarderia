class ActivitiesController < ApplicationController
  before_action :set_params 
  
  def index
   @activities = Activity.all.order('name ASC')
   @list = Activity.all.order('name ASC')
   @list = Activity.where(id: @name).order('name ASC') if  @name.present?
   @list = @list.paginate(page: params[:page], per_page: 50)
  end

  private
  def set_params
    @name = params["name"]
  end
end
