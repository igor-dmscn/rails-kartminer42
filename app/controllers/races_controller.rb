class RacesController < ApplicationController
  before_action :find_race, only: [:show, :destroy]
  def index
    @races = Race.all.includes(:placements).order('placements.position ASC')
  end

  def show;  end

  def destroy
    @race.destroy

    head :ok
  end

  private
  def find_race
    @race = Race.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: true, message: 'Not found' }, status: :not_found
  end
end
