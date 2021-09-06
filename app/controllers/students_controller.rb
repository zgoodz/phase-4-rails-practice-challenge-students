class StudentsController < ApplicationController
    wrap_parameters format: []

    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response


    def index
        render json: Student.all
    end

    def show
        render json: Student.find_by(id: params[:id])
    end

    def create
        student = Student.create(student_params)
        render json: student, status: :created
    end

    def update
        student = Student.find_by(id: params[:id])
        student.update(student_params)
        render json: student, status: :accepted
    end

    def destroy
        student = Student.find_by(id: params[:id])
        student.destroy
        head :no_content
    end

    private

    def student_params
        params.permit(:name, :major, :age, :instructor_id)
    end

    def render_unprocessable_entity_response(invalid)
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end

    def render_not_found_response(exception)
        render json: { error: "#{exception.model} not found" }, status: :not_found
    end
end
