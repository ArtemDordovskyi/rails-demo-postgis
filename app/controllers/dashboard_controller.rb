class DashboardController < ApplicationController
  def index
    @military_fired = MilitaryFired.coordinates
  end
end
