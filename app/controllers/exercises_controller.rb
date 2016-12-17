class ExercisesController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :find_workout!

  def index
    @exercises = @workout.exercises.order(created_at: :desc)
  end

  def create
    @exercise = @workout.exercises.new(exercise_params)
    @exercise.user = current_user

    render json: { errors: @exercise.errors }, status: :unprocessable_entity unless @exercise.save
  end

  def update
    @exercise = Exercise.find(params[:id])

    if @exercise.user_id == @current_user_id
      @exercise.update_attributes(exercise_params)

      render :show
    else
      render json: { errors: { exercise: ['not owned by user'] } }, status: :forbidden
    end
  end

  def destroy
    @exercise = @workout.exercises.find(params[:id])

    if @exercise.user_id == @current_user_id
      @exercise.destroy
      render json: {}
    else
      render json: { errors: { exercise: ['not owned by user'] } }, status: :forbidden
    end
  end

  private

  def exercise_params
    params.require(:exercise).permit(:type, :name, :sets, :reps, :description)
  end

  def find_workout!
    @workout = Workout.find_by_slug!(params[:workout_slug])
  end
end
