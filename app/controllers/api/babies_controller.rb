module Api
  class BabiesController < ApplicationController
    skip_before_action :verify_authenticity_token
    skip_before_action :authenticate_user!

    def index
      babies = Baby.order('id').paginate(page: page, per_page: per_page);
      babies = babies.map do |row|
        { id: row.id, name: row.name, 
          age: AgeCalculator.new(row.birthday).age * 12,
          mother_name: row.mother_name,
          father_name: row.father_name,
          address: row.address,
          phone: row.phone
       }
        
      end
      render json: {status: 'SUCCESS', message: 'Loaded Babies', data: babies }, status: :ok
    end

    def create
      babies = Baby.new(baby_params)
      if babies.save
        render json: {status: 'SUCCESS', message: 'Saved Baby', data: babies }, status: :ok
      else
        render json: {status: 'ERROR', message: 'Baby not saved', data: babies.errors}, status: :unprocessable_entity
      end
    end

    def show
      babies = Baby.find(params[:id])
      render json: {status: 'SUCCESS', message: 'Baby Loaded', data: babies }, status: :ok
    end

    def destroy
      babies = Baby.find(params[:id])
      babies.destroy
      render json: {status: 'SUCCESS', message: 'Deleted Baby', data: babies }, status: :ok
    end

    def update
      babies = Baby.find(params[:id])
      if babies.update_attributes(baby_params)
        render json: {status: 'SUCCESS', message: 'Updated Baby', data: babies }, status: :ok
      else
        render json: {status: 'ERROR', message: '  Baby not updated', data: babies.errors}, status: :unprocessable_entity
      end
    end

    private
    
    def baby_params
      params.permit( :name, :birthday, :mother_name,:father_name, :address, :phone)
    end

    def page
      @page ||= params[:page] || 1
    end
    
    def per_page
      @per_page ||= params[:per_page] || 5
    end  

  end
end  