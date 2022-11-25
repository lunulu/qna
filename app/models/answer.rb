class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user

  has_many_attached :files, dependent: :destroy

  validates :body, presence: true

  def mark_as_best
    question.update(answer_id: id)
  end

  def delete_file(file_id)
    files.where(id: file_id).purge_later
  end
end
