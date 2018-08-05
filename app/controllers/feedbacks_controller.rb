class FeedbacksController < ApplicationController
  def create
    Feedback.create(feedback_params)
    flash[:notice] = I18n.t('feedback.success')
    @random_products = Product.order("RANDOM()").first(3)
    redirect_to root_path
  end

  def feedback_params
    params.require(:feedback).permit(:name, :email, :text)
  end
end
