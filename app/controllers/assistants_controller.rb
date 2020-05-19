class AssistantsController < ApplicationController
  before_action :set_params 
  
  def index
   @assistants = Assistant.all.order('name ASC')
   
  @list = Assistant.all.order('name ASC')
  @list = Assistant.where(name: @name).order('name ASC') if  @name.present?
  @list = Assistant.where(group: @group.to_i).order('name ASC') if  @group.present? 
  @list = Assistant.where('assistants.group = ? AND name = ?',  @group, @name ) if  @name.present? and @group.present? 
  @list = @list.paginate(page: params[:page], per_page: 50)
  end

  private
  def set_params
    @name = params["name"] 
    @group = params["group"] 
  end
end
