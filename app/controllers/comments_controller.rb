class CommentsController < ApplicationController
  def index
  end

  def create
    Comment.create(comment_params)
  end

  private

  def comment_params
    params.require(:movie_id).permit(:user_id, :title, :content)
  end
end
