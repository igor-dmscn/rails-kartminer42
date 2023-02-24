class RacersController < ApplicationController
  before_action :find_racer, only: [:show, :update, :destroy]

  def index
    @racers = Racer.all
  end

  def show; end

  def create
    @racer = Racer.new(racer_params)

    if @racer.save
      head :created
    else
      head :bad_request
    end
  end

  def update
    if @racer.update(racer_params)
      head :ok
    else
      head :bad_request
    end
  end

  def destroy
    @racer.destroy

    head :ok
  end

  private
  def find_racer
    @racer = Racer.find(params[:id])
  rescue Exception
    render json: { error: true, message: 'Not found' }, status: :not_found
  end

  def racer_params
    params.required(:racer).permit(:name, :born_at, :image_url)
  end
end
