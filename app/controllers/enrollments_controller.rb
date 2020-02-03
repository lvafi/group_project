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
                redirect_to course_path(course)
            else
                @courses = Course.all.order(created_at: :DESC)
                render 'courses/show'
            end
        else
            redirect_to course
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
            redirect_to course_path(course)
        else
            flash[:alert] = "Enrollment deletion failed."
            render 'courses/show'
        end
    end

    def approving
        @enrollment = Enrollment.find(params[:enrollment_id])
        @enrollment.approving!
        redirect_to course_path(@enrollment.course)
    end
    def rejecting
        @enrollment = Enrollment.find(params[:enrollment_id])
        @enrollment.rejecting!
        redirect_to course_path(@enrollment.course)
    end

    def enrolled_courses
        @courses = current_user.enrolled_courses 
        #render 'courses/index'
    end

    def approving
        @enrollment = Enrollment.find(params[:enrollment_id])
        @enrollment.approving!
        redirect_to course_path(@enrollment.course)
    end

    def rejecting
        @enrollment = Enrollment.find(params[:enrollment_id])
        @enrollment.rejecting!
        redirect_to course_path(@enrollment.course)
    end

end
