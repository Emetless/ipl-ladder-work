class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @comment.author_id = current_user.id
    @comment.save
    respond_to do |format|
      format.json {
        render json: {
          author: User.find(@comment.author_id).email,
          content: @comment.content,
          answered: 'answered'
        }
      }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :article_id)
  end
end
