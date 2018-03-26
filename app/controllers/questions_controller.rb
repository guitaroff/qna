class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  respond_to :html

  def index
    respond_with(@questions = Question.all)
  end

  def show
    @answer  = @question.answers.build
    @comment = @question.comments.build
    respond_with @question
  end

  def new
    respond_with(@question = Question.new)
  end

  def create
    @question = Question.new(question_params)
    flash[:notice] = 'Your question successfully created' if @question.save
    respond_with @question
  end

  def edit
  end

  def update
    @question.update(question_params)
    respond_with @question
  end

  def destroy
    respond_with(@question.destroy)
  end

  private

  def set_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body, attachments_attributes: [:file])
  end
end
