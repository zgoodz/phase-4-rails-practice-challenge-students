class InstructorsController < ApplicationController
wrap_parameters format: []

    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response


    def index
        render json: Instructor.all
    end

    def show
        render json: Instructor.find_by(id: params[:id])
    end

    def create
        instructor = Instructor.create(instructor_params)
        render json: instructor, status: :created
    end

    def update
        instructor = Instructor.find_by(id: params[:id])
        instructor.update(instructor_params)
        render json: instructor, status: :accepted
    end

    def destroy
        instructor = Instructor.find_by(id: params[:id])
        instructor.destroy
        head :no_content
    end

    private

    def instructor_params
        params.permit(:name)
    end

    def render_unprocessable_entity_response(invalid)
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end

    def render_not_found_response(exception)
        render json: { error: "#{exception.model} not found" }, status: :not_found
    end

end
