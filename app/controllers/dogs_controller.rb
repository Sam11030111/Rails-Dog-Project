class DogsController < ApplicationController
    def index
      @dogs = Dog.page(params[:page]).per(10)
    end

    def show
      @dog = Dog.find(params[:id])
    end
end