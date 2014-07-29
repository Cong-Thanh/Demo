class TpbQueriesController < ApplicationController

  def show
    if params[:q].present?
      params[:page] = params[:page].try(:to_i) || 0
      @results = ThePirateBay::Search.new(params[:q], params[:page], ThePirateBay::SortBy::Uploaded, params[:category]).results
    else
      @results = []
    end
  end
end
