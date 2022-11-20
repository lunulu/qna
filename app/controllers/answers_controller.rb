class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_question, only: %i[create]
  before_action :load_answer, only: %i[destroy]

  def create
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user

    if @answer.save
      redirect_to @answer.question, notice: 'Your answer successfully posted.'
    else
      render 'questions/show'
    end
  end

  def destroy
    @answer.destroy if @answer.user == current_user
    redirect_to question_path(@answer.question), notice: 'Your answer was successfully deleted.'
  end

  private

  def load_question
    @question = Question.find(params[:question_id])
  end

  def load_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body)
  end
end
