class OwnersController < ApplicationController
    def index
      @owners = Owner.page(params[:page]).per(10)
    end

    def show
      @owner = Owner.find(params[:id])
      @dogs = @owner.dogs.page(params[:page]).per(10)
    end
end