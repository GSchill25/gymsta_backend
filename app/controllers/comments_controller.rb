class CommentsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :find_workout!

  def index
    @comments = @workout.comments.order(created_at: :desc)
  end

  def create
    @comment = @workout.comments.new(comment_params)
    @comment.user = current_user

    render json: { errors: @comment.errors }, status: :unprocessable_entity unless @comment.save
  end

  def destroy
    @comment = @workout.comments.find(params[:id])

    if @comment.user_id == @current_user_id
      @comment.destroy
      render json: {}
    else
      render json: { errors: { comment: ['not owned by user'] } }, status: :forbidden
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def find_workout!
    @workout = Workout.find_by_slug!(params[:workout_slug])
  end
end
