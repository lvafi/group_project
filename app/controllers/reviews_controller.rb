class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_course,only:[:create,:destroy]
  
  def create
    @review = Review.new review_params
    @review.course = @course
    @review.user = current_user

    if @review.save
      flash[:success] = "Thanks for your review!"
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
  def find_course
    @course = Course.find params[:course_id]

  end
  # //def authorize!
  # //redirect_to root_path, alert: "access denied" unless can?:crud,@course
  # //end
end

