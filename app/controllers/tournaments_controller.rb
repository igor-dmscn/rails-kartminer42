class TournamentsController < ApplicationController
  before_action :find_tournament, only: [:show]
  def create
    @tournament = Tournament.new(tournament_params)

    if @tournament.save
      head :created
    else
      head :bad_request
    end
  end

  def index
    @tournaments = Tournament.all.includes(:races)
  end

  def show
    @racers = Racer.from_tournament(@tournament.id)
  end

  private
  def find_tournament
    @tournament = Tournament.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: true, message: 'Not found' }, status: :not_found
  end
  def tournament_params
    params.required(:tournament).permit(:name)
  end
end
