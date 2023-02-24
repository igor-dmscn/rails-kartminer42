class RacersController < ApplicationController
  def index
    @racers = Racer.all
    render json: @racers
  end
end
