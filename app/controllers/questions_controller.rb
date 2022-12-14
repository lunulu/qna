class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :load_question, only: %i[show edit update destroy delete_file]
  def index
    @questions = Question.all
  end

  def show
    @answer = Answer.new
    @best_answer = @question.best_answer
    @answers = @question.answers.where.not(id: @best_answer)
  end

  def new
    @question = Question.new
    @question.build_reward
  end

  def edit
    @question.reward.present? ? @question.reward : @question.build_reward
  end

  def create
    @question = Question.new(question_params)
    @question.user = current_user

    if @question.save
      redirect_to @question, notice: 'Your question successfully created.'
    else
      render :new
    end
  end

  def update
    if @question.update(question_params)
      redirect_to @question, notice: 'Your question successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @question.destroy if @question.user == current_user
    redirect_to questions_path, notice: 'Your question was successfully deleted.'
  end

  def delete_file
    @question.delete_file(params[:file_id])
    redirect_to @question
  end

  private

  def load_question
    @question = Question.with_attached_files.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body,
                                     files: [],
                                     links_attributes: %i[id name url _destroy],
                                     reward_attributes: %i[id title image _destroy])
  end
end
