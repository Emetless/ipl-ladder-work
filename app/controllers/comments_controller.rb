class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @comment.author_id = current_user.id
    @comment.save
    redirect_to root_path
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :article_id)
  end
end
