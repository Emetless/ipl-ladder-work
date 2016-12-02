class CommentsController < ApplicationController
  def create
    @comment = Comment.new do |commemt|
      comment.content = 
    end
  end

  private

  def comment_params
    params.require :comment
  end
end
