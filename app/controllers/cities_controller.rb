class CitiesController < ApplicationController
  before_action :set_city, only: [:show]

  # GET /cities/1
  # GET /cities/1.json
  def show
    @movies = @city.current_movies
  end

  def index
    @city = City.default_city
    @movies = @city.current_movies
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_city
      @city = City.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def city_params
      params[:city]
    end
end
