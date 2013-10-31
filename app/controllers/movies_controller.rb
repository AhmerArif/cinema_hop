class MoviesController < ApplicationController
  before_action :set_movie, only: [:show]

  def show
    @cinemas = @city.current_cinemas(@movie)
    if @cinemas.blank?
      flash[:notice] = "That movie isn't currently showing in the specified location"
      redirect_to root_path
    end
    js false
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @city = City.find_by slug: params[:city_id] 
      @city ||= City.default_city
      @movie = Movie.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def movie_params
      params[:movie]
    end

    rescue_from ActiveRecord::RecordNotFound do
      flash[:notice] = "We don't know about the movie you are trying to access"
      redirect_to root_path
    end

end
