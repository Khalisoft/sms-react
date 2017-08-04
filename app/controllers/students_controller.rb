class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :update, :destroy]

  # GET /students
  def index
    @student = Student.all
    render json: @student
  end

  # GET /students/1
  def show
    render json: @student
  end

  # POST /students
  def create
    @student = Student.new(student_params)

    if @student.save
      render json: @student, status: :created, location: @student
    else
      render json: @student.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /students/1
  def update
    if @post.update(student_params)
      render json: @student
    else
      render json: @student.errors, status: :unprocessable_entity
    end
  end

  # DELETE /students/1
  def destroy
    @post.destroy
  end

  private

  def set_student
    @student = Student.find(params[:id])
  end

  def student_params
    params.require(:post).permit(:first_name, :last_name, :country, :experiences)
  end
end
