class TournamentsController < ApplicationController
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

  private
  def tournament_params
    params.required(:tournament).permit(:name)
  end
end
