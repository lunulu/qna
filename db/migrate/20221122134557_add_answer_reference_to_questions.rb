class AddAnswerReferenceToQuestions < ActiveRecord::Migration[6.1]
  def change
    add_reference :questions, :answer
  end
end
