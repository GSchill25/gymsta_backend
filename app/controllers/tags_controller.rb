class TagsController < ApplicationController
  def index
    render json: { tags: Workout.tag_counts.most_used.map(&:name) }
  end
end
