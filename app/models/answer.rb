class Answer < ApplicationRecord
  has_many :links, as: :linkable, dependent: :destroy
  belongs_to :question
  belongs_to :user

  has_many_attached :files, dependent: :destroy

  accepts_nested_attributes_for :links, reject_if: :all_blank, allow_destroy: true

  validates :body, presence: true

  def mark_as_best
    question.update(best_answer: self)
    question.reward.update(user: user) if question.reward.present?
  end

  def delete_file(file_id)
    files.where(id: file_id).purge_later
  end
end
