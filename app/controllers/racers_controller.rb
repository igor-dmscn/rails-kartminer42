class RacersController < ApplicationController
  before_action :find_racer, only: [:show]

  def index
    @racers = Racer.all
  end

  def show; end

  private
  def find_racer
    @racer = Racer.find(params[:id])
  rescue Exception
    render json: { error: true, message: 'Not found' }, status: :not_found
  end
end
