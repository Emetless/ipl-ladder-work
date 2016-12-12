class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @comment.author_id = current_user.id
    @comment.save
    respond_to do |format|
      format.json {
        render json: {
          id: @comment.id,
          author: User.find(@comment.author_id).email,
          content: @comment.content,
          answered: t('answered'),
          destroy: t('destroy')
        }
      }
    end
  end

  def destroy
    set_comment
    @comment.destroy
    respond_to do |format|
      format.json { render json: { success: true } }
    end
  end

  private

  def set_comment
    searched_comment = Comment.find params.require(:comment).permit(:id)[:id]
    if current_user.admin? || searched_comment.author_id == current_user.id
      @comment = searched_comment
    end
  end

  def comment_params
    params.require(:comment).permit(:content, :article_id)
  end
end
