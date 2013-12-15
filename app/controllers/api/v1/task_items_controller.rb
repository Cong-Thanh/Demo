class Api::V1::TaskItemsController < Api::ApiController
  respond_to :json

  def index
    respond_with TaskItem.all
  end
  
  def show
    respond_with Product.find(params[:id])
  end

  def create
    respond_with TaskItem.create(task_item_params), location: nil
  end

  def update
    respond_with Product.update(params[:id], product_params)
  end

  def destroy
    respond_with Product.destroy(params[:id])
  end

  private

  def task_item_params
    params.require(:task_item).permit(:description, :due_date)
  end
end