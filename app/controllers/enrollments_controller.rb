class EnrollmentsController < ApplicationController

    before_action :authenticate_user!

    def create
        course = Course.find params[:course_id]
        enroll = Enrollment.new user: current_user, course: course
        if course.user != current_user
            if !can?(:enroll, course)
                redirect_to course
            elsif enroll.save
                redirect_to course, notice: 'Enrolled'
            else
                redirect_to course, alert: 'Not Enrolled'
            end
        else
            redirect_to course, alert: "You created the course, cannot add yoruself as a student. Sorry."
        end
    end

    def destroy
        enroll = Enrollment.find params[:id]
        if can? :destory, enroll
            enroll.destroy
            redirect_to enroll.course, notice: 'Enrollment removed'
        else
            redirect_to enroll.course, alert: "Can't delete enrollment"
        end
    end

end
