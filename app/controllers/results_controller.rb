class ResultsController < ApplicationController

  def index
    @rooms = Room.all
    @search_results_rooms = Room.search_everywhere(params[:query])
    @search_results_telechannels = Telechannel.search_everywhere(params[:query])
    @search_results_microposts = Micropost.search_everywhere(params[:query])
  end
end
