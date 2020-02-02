class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def create
    @course = Course.find params[:course_id]
    @review = Review.new review_params
    @review.course = @course
    @review.user = current_user

    if @review.save
      flash[:success] = "Review created successfully"
      redirect_to @course
    else
      @reviews = @course.reviews.order(created_at: :desc)
      render 'courses/show'
    end

  end

  def destroy
    @review = Review.find params[:id]
    if can? :crud, @review
        @review.destroy
        flash[:alert] = "Review deleted successfully"
        redirect_to @review.course
    end
  end

  private

  def review_params
    params.require(:review).permit(:body, :rating)
  end

end
