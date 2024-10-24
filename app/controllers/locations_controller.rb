class LocationsController < ApplicationController
    def index
      @locations = Location.page(params[:page]).per(10)
    end

    def show
      @location = Location.find(params[:id])
      @dogs = @location.dogs.page(params[:page]).per(10)
    end
end