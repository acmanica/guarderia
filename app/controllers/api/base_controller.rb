module Api
  class BaseController < ApplicationController
      
    def page
      @page ||= params[:page] || 1
    end
    
    def per_page
      @per_page ||= params[:per_page] || 5
    end
  end
end