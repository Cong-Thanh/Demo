class Api::V1::ContactsController < Api::ApiController
  respond_to :json

  def index
    respond_with Contact.all
  end
  
  def show
    respond_with Contact.find(params[:id])
  end

  def create
    respond_with Contact.create(contact_params), location: nil
  end

  def update
    respond_with Contact.update(params[:id], contact_params)
  end

  def destroy
    respond_with Contact.destroy(params[:id])
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :phone, :email, :phone_book_id)
  end
end