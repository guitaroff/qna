class CommentsController < ApplicationController
  before_action :set_question!, only: :create

  def create
    @comment = @question.comments.build(comment_params)
    @comment.save
    redirect_to question_path @question
  end

  private

  def set_question!
    @question = Question.find(params[:question_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to :root, alert: 'Вопрос не найден'
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
