class WorkoutsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @workouts = Workout.all.includes(:user)

    @workouts = @workouts.tagged_with(params[:tag]) if params[:tag].present?
    @workouts = @workouts.authored_by(params[:author]) if params[:author].present?
    @workouts = @workouts.favorited_by(params[:favorited]) if params[:favorited].present?

    @workouts_count = @workouts.count

    @workouts = @workouts.order(created_at: :desc).offset(params[:offset] || 0).limit(params[:limit] || 20)
  end

  def feed
    @workouts = Workout.includes(:user).where(user: current_user.following_users)

    @workouts_count = @workouts.count

    @workouts = @workouts.order(created_at: :desc).offset(params[:offset] || 0).limit(params[:limit] || 20)

    render :index
  end

  def create
    @workout = Workout.new(workout_params)
    @workout.user = current_user

    if @workout.save
      render :show
    else
      render json: { errors: @workout.errors }, status: :unprocessable_entity
    end
  end

  def show
    @workout = Workout.find_by_slug!(params[:slug])
  end

  def update
    @workout = Workout.find_by_slug!(params[:slug])

    if @workout.user_id == @current_user_id
      @workout.update_attributes(workout_params)

      render :show
    else
      render json: { errors: { workout: ['not owned by user'] } }, status: :forbidden
    end
  end

  def destroy
    @workout = Workout.find_by_slug!(params[:slug])

    if @workout.user_id == @current_user_id
      @workout.destroy

      render json: {}
    else
      render json: { errors: { workout: ['not owned by user'] } }, status: :forbidden
    end
  end

  private

  def workout_params
    params.require(:workout).permit(:title, :subtitle, tag_list: [])
  end
end
