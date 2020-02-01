class SchoolsController < ApplicationController
        # before_action :authenticate_user!, except: [:index, :show]
        before_action :find_school, only: [:show, :edit, :update,:destroy]
        # before_action :authorize!, only: [:edit, :update, :destroy]
    
        def new
            @school = School.new
        end

        def create
            @school = School.new school_params
            @school.user = current_user
            if @school.save
                flash[:notice] = 'School added successfully'
                redirect_to school_path(@school.id)
            else
                render :new
            end
        end

        def edit
        
        end
    
        def update
            if @school.update school_params
                flash[:notice] = 'School updated successfully'
                redirect_to school_path(@school.id)
            else
                render :edit
            end
        end

        def index
            @schools = School.all.order(created_at: :desc)
        end
    
        def show
            @rooms = @school.rooms.order(created_at: :desc)
        end
    
        def destroy
            @school.destroy
            redirect_to schools_path
        end
    
        private
    
        def find_school
            @school = School.find params[:id]
        end
        
        def school_params
            params.require(:school).permit(:name, :logo_url)
        end
    
        # def authorize!
        #     unless can?(:crud, @school)
        #         redirect_to root_path, alert: 'Not Authorized'
        #     end
        # end
end
