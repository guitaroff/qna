class AnswersController < ApplicationController
  before_action :set_question!, only: :create
  before_action :set_answer!, only: :update
  after_action :publish_answer, only: :create

  respond_to :js
  respond_to :json, only: :create

  def create
    respond_with(@answer = @question.answers.create(answer_params))
  end

  def update
    @answer.update(answer_params)
    respond_with @answer
  end

  private

  def answer_params
    params.require(:answer).permit(:body, attachments_attributes: [:file])
  end

  def set_question!
    @question = Question.find(params[:question_id])
  end

  def set_answer!
    @answer   = Answer.find(params[:id])
    @question = @answer.question
  end

  def publish_answer
    PrivatePub.publish_to "/questions/#{@question.id}/answers", answer: @answer.to_json if @answer.valid?
  end
end
