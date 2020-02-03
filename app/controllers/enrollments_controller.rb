class EnrollmentsController < ApplicationController

    before_action :authenticate_user!

    def create
        course = Course.find params[:course_id]
        enroll = Enrollment.new user: current_user, course: course
        if course.user != current_user
            # if !can?(:enroll, course)
            #     redirect_to course
            if enroll.save
                redirect_to course, notice:  'Congratulations! You are now enrolled in the course.'
            else
                redirect_to course, notice: 'Enrollment failed. Please try again.'
            end
        else
            redirect_to course, notice: "Course creators are not permitted to enroll in their own courses."
        end
    end

    def destroy
        enroll = Enrollment.find params[:id]
        course = enroll.course
        # if can? :destory, enroll
        if enroll.user == current_user
            enroll.destroy
            flash[:notice] = "You are no longer enrolled in the course."
            redirect_to course
        else
            flash[:alert] = "Enrollment deletion failed."
            redirect_to course
        end
    end

end
