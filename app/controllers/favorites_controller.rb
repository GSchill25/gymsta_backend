class FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_workout!

  def create
    current_user.favorite(@workout)

    render 'workouts/show'
  end

  def destroy
    current_user.unfavorite(@workout)

    render 'workouts/show'
  end

  private

  def find_workout!
    @workout = Workout.find_by_slug!(params[:workout_slug])
  end
end
