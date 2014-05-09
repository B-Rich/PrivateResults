class HomeController < ApplicationController
  def index
    @infections = Infection.all
  end
end
