class Question < ApplicationRecord
  has_many :answers
  has_many :attachments, as: :attachmentable
  accepts_nested_attributes_for :attachments
  has_many :comments, as: :commentable

  validates :title, :body, presence: true
end
