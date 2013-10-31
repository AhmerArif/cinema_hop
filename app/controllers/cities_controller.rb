class CitiesController < ApplicationController
  before_action :set_city, only: [:show]

  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found

  # GET /cities/1
  # GET /cities/1.json
  def show
    @movies = @city.current_movies
    js false
  end

  def index
    @city = City.default_city
    @movies = @city.current_movies
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_city
      @city = City.find_by slug: params[:id] 
      @city ||= City.default_city
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def city_params
      params[:city]
    end
end
