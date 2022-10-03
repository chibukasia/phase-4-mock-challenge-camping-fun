class CampersController < ApplicationController
    wrap_parameters format: []

    rescue_from ActiveRecord::RecordInvalid, with: :response_for_unprocessable_entity
    rescue_from ActiveRecord::RecordNotFound, with: :camper_not_found

    # Get all the campers
    def index 
        campers = Camper.all 
        render json: campers, status: :ok
    end 

    # Get specific camper 
    def show 
        camper = find_camper 
        render json: camper, serializer: CamperActivitiesSerializer, status: :ok
    end 

    # Post a camper 
    def create 
        camper = Camper.create!(camper_params)
        render json: camper, status: :created
    end 

    # # Delete a camper 
    # def destroy 
    #     camper = find_camper
    #     camper.destroy
    #     head :no_content
    # end 

    # Private methods 

    private
    # Find activity
    def find_camper
        Camper.find(params[:id])
    end 

    # Permitted parameters 
    def camper_params
        params.permit(:name, :age) 
    end 

    # Camper not found response 
    def camper_not_found 
        render json: {error: "Camper not found"}, status: :not_found
    end 

    # Catch invalid data response
    def response_for_unprocessable_entity(err) 
        render json: {errors: err.record.errors.full_messages}, status: :unprocessable_entity
    end


end
