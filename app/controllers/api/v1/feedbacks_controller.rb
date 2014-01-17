class Api::V1::FeedbacksController < Api::ApiController
  respond_to :json
  
  def create
    respond_with Feedback.create(feedback_params), location: nil
  end

  private

  def feedback_params
    params.require(:feedback).permit(:email, :comment)
  end
end
