class ActivitiesController < ApplicationController
    wrap_parameters format: []
    
    rescue_from ActiveRecord::RecordNotFound, with: :activity_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :response_for_unprocessable_entity 

    # Get all activities
    def index
        activities = Activity.all 
        render json: activities, status: :ok
    end 

    # Get specific activity
    # def show 
    #     activity = find_activity 
    #     render json: activity, status: :ok 
    # end 

    # Post an activity
    def create 
        activity = Activity.create!(activity_params)
        render json: activity, status: :created
    end
    
    # Delete an activity 
    def destroy
        activity = find_activity
        activity.destroy
        head :no_content
    end 

    # Private methods 
    private 

    # Find an activity
    def find_activity
        Activity.find(params[:id])
    end 

    # Permitted params 
    def activity_params
        params.permit(:name, :difficulty)
    end
    # Response for not found activity
    def activity_not_found
        render json: {error: "Activity not found"}, status: :not_found
    end 

    # Response for invalid entities
    def response_for_unprocessable_entity(err) 
        render json: {errors: err.record.errors.full_messages}, status: :unprocessable_entity
    end

end
