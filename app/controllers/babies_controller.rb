class BabiesController < ApplicationController
  before_action :set_params 
  
  def index
    @list = Baby.all.order('name ASC')
    @babies_select = @list

    @list = @list.where(name: @baby_name ) if  @baby_name.present?
    @list = @list.where(mother_name: @mother_name ) if  @mother_name.present?
    @list = @list.where(father_name: @father_name ) if  @father_name.present?
    
    @list = @list.paginate(page: params[:page], per_page: 50)
  end

  def new
    @baby = Baby.new()
  end

  def create
    @baby = Baby.new(baby_params)
    if @baby.save
      flash[:success] = "Bebe was succesfully created"
      redirect_to baby_path(@baby)
    else
      render 'new'
    end
  end

  def show
    @baby = Baby.find(params[:id])
  end

  def edit
     @baby = Baby.find(params[:id])
  end

    def update
    @baby = Baby.find(params[:id])
    if @baby.update(baby_params)
      flash[:success] = "bebe was succesfully update"
      redirect_to baby_path(@baby)
    else
      render 'edit' 
    end 
  end

    def destroy
    @baby = Baby.find(params[:id])
    @baby.destroy
    flash[:danger] =  "Bebe was deleted"
    redirect_to babies_path
  end
  
  private
  def set_params
    @baby_name ||= params["baby_name"] 
    @mother_name ||= params["mother_name"] 
    @father_name ||= params["father_name"]
  end

  def baby_params
    params.require(:baby).permit(:name, :birthday, :father_name, :phone, :address)
  end  
end
