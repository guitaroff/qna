class AnswersController < ApplicationController
  before_action :set_question, only: :create

  def create
    @answer = @question.answers.build(answer_params)
    @answer.save
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end

  def set_question
    @question = Question.find(params[:question_id])
  end
end
