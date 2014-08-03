class TpbQueriesController < ApplicationController
  layout false

  def show
  end

  def create
    params[:page] = params[:page].try(:to_i) || 0
    @results = ThePirateBay::Search.new(params[:q], params[:page], ThePirateBay::SortBy::Uploaded, params[:category]).results
    render partial: "results", locals: {results: @results}
  end
end
