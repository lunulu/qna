class Question < ApplicationRecord
  has_many :answers, dependent: :destroy
  belongs_to :best_answer, class_name: 'Answer', foreign_key: :answer_id, optional: true, inverse_of: :question
  belongs_to :user

  has_many_attached :files

  validates :title, :body, presence: true

  def delete_file(file_id)
    files.where(id: file_id).purge_later
  end
end
