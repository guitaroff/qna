class Answer < ApplicationRecord
  belongs_to :question
  has_many :attachments, as: :attachmentable
  accepts_nested_attributes_for :attachments
  has_many :comments, as: :commentable
  belongs_to :user

  validates :body, presence: true
end
