class RacesController < ApplicationController
  def index
    @races = Race.all.includes(:placements).order('placements.position ASC')
  end
end
