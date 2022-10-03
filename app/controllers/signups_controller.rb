class SignupsController < ApplicationController
    wrap_parameters format: []

    rescue_from ActiveRecord::RecordNotFound, with: :signup_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :response_for_unprocessable_entity
    # # Get all signups 
    # def index 
    #     signups = Signup.all 
    #     render json: signups, status: :ok
    # end 

    # # Get specif signup
    # def show 
    #     signup = find_signup
    #     render json: signup, status: :ok
    # end 

    # Post signup
    def create 
        signup = Signup.create!(signup_params) 
        activity = signup.activity
        render json: activity, status: :created
    end 

    # Delete signup 
    def destroy 
        signup = find_signup
        signup.destroy
        head :no_content
    end

    # Private methods
    private 

    # Find the signups 
    def find_signup 
        Signup.find(params[:id]) 
    end 

    # Permitted paramters 
    def signup_params
        params.permit(:time, :camper_id, :activity_id)
    end
    # Render the signup not found error 
    def signup_not_found 
        render json: {error: "Signup not found"}, status: :not_found 
    end 

    # Response for invalid record 
    def response_for_unprocessable_entity(err) 
        render json: {errors: err.record.errors.full_messages}, status: :unprocessable_entity 
        # render json: {errors: err.record.errors.full_messages}, status: :unprocessable_entity
    end
end
