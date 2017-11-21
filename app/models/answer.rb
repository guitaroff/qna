class Answer < ApplicationRecord
  belongs_to :question
  has_many :attachments, as: :attachmentable
  accepts_nested_attributes_for :attachments

  validates :body, presence: true
end
