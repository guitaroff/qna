class AnswersController < ApplicationController
  before_action :set_question, only: :create

  def create
    @answer = @question.answers.build(answer_params)

    respond_to do |format|
      if @answer.save
        format.js do
          PrivatePub.publish_to "/questions/#{@question.id}/answers", answer: @answer.to_json
          render nothing:true
        end
      else
        format.js
      end
    end
  end

  def update
    @answer = Answer.find(params[:id])
    @answer.update(answer_params)
    @question = @answer.question
  end

  private

  def answer_params
    params.require(:answer).permit(:body, attachments_attributes: [:file])
  end

  def set_question
    @question = Question.find(params[:question_id])
  end
end
