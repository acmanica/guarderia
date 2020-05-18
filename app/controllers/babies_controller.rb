class BabiesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  before_action :set_params 
  
  def index
    @list = Baby.all.order('name ASC')
    @babies_select = @list

    @list = @list.where(name: @baby_name ) if  @baby_name.present?
    @list = @list.where(mother_name: @mother_name ) if  @mother_name.present?
    @list = @list.where(father_name: @father_name ) if  @father_name.present?
    
    @list = @list.paginate(page: params[:page], per_page: 50)
  end

  private
  def set_params
    @baby_name ||= params["baby_name"] 
    @mother_name ||= params["mother_name"] 
    @father_name ||= params["father_name"]
  end
end
