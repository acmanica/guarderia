module Api
  class AssistantsController < ApplicationController
    skip_before_action :verify_authenticity_token
    skip_before_action :authenticate_user!
    before_action :authenticate_api
    
    def index
      assistants = Assistant.order('created_at DESC').paginate(page: page, per_page: per_page)
      render json: {status: 'SUCCESS', message: 'Loaded Assistants', data: assistants }, status: :ok
    end
    
    def create
      assistants = Assistant.new(assistants_params)
      if assistants.save
        render json: {status: 'SUCCESS', message: 'Saved Assistant', data: assistants }, status: :ok
      else
        render json: {status: 'ERROR', message: 'Assistant not saved', data: assistants.errors}, status: :unprocessable_entity
      end
    end

    def show
      assistants = Assistant.find(params[:id])
      render json: {status: 'SUCCESS', message: 'Assistant Loaded', data: assistants }, status: :ok
    end

    def destroy
      assistants = Assistant.find(params[:id])
      assistants.destroy
      render json: {status: 'SUCCESS', message: 'Deleted Assistant', data: assistants }, status: :ok
    end

    def update
      assistants = Assistant.find(params[:id])
      if assistants.update_attributes(assistants_params)
        render json: {status: 'SUCCESS', message: 'Updated Assistant', data: assistants }, status: :ok
      else
        render json: {status: 'ERROR', message: '  Assistant not updated', data: assistants.errors}, status: :unprocessable_entity
      end
    end

    private
    def assistants_params
      params.permit( :name, :group, :address, :phone)
    end
    
    def page
      @page ||= params[:page] || 1
    end
    
    def per_page
      @per_page ||= params[:per_page] || 5
    end  
  end
end  