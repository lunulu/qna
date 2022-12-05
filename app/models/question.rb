class Question < ApplicationRecord
  has_many :answers, dependent: :destroy
  has_many :links, as: :linkable, dependent: :destroy
  has_one :reward, dependent: :destroy
  belongs_to :best_answer, class_name: 'Answer', foreign_key: :answer_id, optional: true, inverse_of: :question
  belongs_to :user

  has_many_attached :files

  accepts_nested_attributes_for :links, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :reward, reject_if: :all_blank, allow_destroy: true

  validates :title, :body, presence: true

  def delete_file(file_id)
    files.where(id: file_id).purge_later
  end
end
