class EnrollmentsController < ApplicationController

    before_action :authenticate_user!

    def create
        course = Course.find params[:course_id]
        enroll = Enrollment.new user: current_user, course: course
        if course.user != current_user
            # if !can?(:enroll, course)
            #     redirect_to course
            if enroll.save
                flash[:notice] = 'Congratulations! You are now enrolled in the course.'
                @courses = Course.all.order(created_at: :DESC)
                render 'courses/index'
            else
                @courses = Course.all.order(created_at: :DESC)
                render 'courses/index'
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
            @courses = Course.all.order(created_at: :DESC)
            render 'courses/index'
        else
            flash[:alert] = "Enrollment deletion failed."
            redirect_to course
        end
    end

    def enrolled_courses
        @courses = current_user.enrolled_courses 
        #render 'courses/index'
    end

end
