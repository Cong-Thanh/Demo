class Api::V1::ProductsController < ApplicationController
  respond_to :json

  def index
    respond_with Product.all
  end
  
  def show
    respond_with Product.find(params[:id])
  end

  def create
    respond_with Product.create(product_params), location: products_path
  end

  def update
    respond_with Product.update(params[:id], product_params)
  end

  def destroy
    respond_with Product.destroy(params[:id])
  end

  private

  def product_params
    params.require(:product).permit(:name, :price, :quantity)
  end
end