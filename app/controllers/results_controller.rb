class ResultsController < ApplicationController

  def index
    @search_results = Room.search_everywhere(params[:query])
  end
end
