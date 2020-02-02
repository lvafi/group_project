class CoursesController < ApplicationController

    before_action :authenticate_user!, except: [:show, :index]
    before_action :find_course, only: [:show, :edit, :udpate, :destroy]
    before_action :authorize!, only: [:edit, :update, :destroy]
    
    def new
        @course = Course.new
    end

    def create
        @course = Course.new course_params
        @course.user = current_user #setting the default owner of the course to be a teacher 

        if @course.save
            flash[:notice] = 'Congratulations! You have created a course.'
            redirect_to courses_path(@course)
        else
            render :new
        end
    end

    def index 
        @courses = Course.all.order(created_at: :DESC)
    end

    def show
        @booking = Booking.new
        @enrollment = Enrollment.new

        #if I'm a teacher (course owner)
        if @course.user == current_user 
            if can? :crud, @course
                @bookings = @course.bookings.order(created_at: :desc)
                @enrollments = @course.enrollments.order(created_at: :desc)
            else
                @bookings = @course.bookings.where(hidden: false).order(created_at: :desc)
                @enrollments = @course.enrollments.where(hidden: false).order(created_at: :desc)
            end
        else #else its a student-user or room-mananger-user
            @bookings = @course.bookings.order(created_at: :desc)  
            @enrollments = current_user.enrollments.map{
                |enrollment| Course.find(enrollment.course_id) 
            }
        end
    end

    def edit
    end

    def update 
        if @course.update course_params
            redirect_to course_path(@course)
        else
            render :edit
        end
    end

    def destroy
        @course.destroy
        flash[:notice] = 'The course has been deleted.'
        redirect_to courses_path
    end

    private
    
    def course_params
        params.require(:course).permit(:title, :description, :price, :range_start_date, :range_end_date)
    end
   
    def find_course
        @course = Course.find params[:id]
    end

    def authorize!
        redirect_to root_path, alert: "Not Authorized" unless can? :crud, @course
    end

end
