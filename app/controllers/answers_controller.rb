class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_question, only: %i[create]
  before_action :load_answer, only: %i[update destroy mark_as_best delete_file]

  def create
    @answer = @question.answers.create(answer_params.to_h.merge(user: current_user))
  end

  def update
    @answer.update(answer_params)
    prepare_question_and_answers
  end

  def destroy
    @answer.destroy if @answer.user == current_user
    prepare_question_and_answers
  end

  def mark_as_best
    @answer.mark_as_best if @answer.question.user == current_user
    redirect_to question_path(@answer.question)
  end

  def delete_file
    @answer.delete_file(params[:file_id])
    redirect_to question_path(@answer.question)
  end

  private

  def load_question
    @question = Question.find(params[:question_id])
  end

  def load_answer
    @answer = Answer.with_attached_files.find(params[:id])
  end

  def prepare_question_and_answers
    @question = @answer.question
    @best_answer = @question.best_answer
    @answers = @question.answers.where.not(id: @best_answer)
  end

  def answer_params
    params.require(:answer).permit(:body, files: [], links_attributes: %i[id name url _destroy])
  end
end
