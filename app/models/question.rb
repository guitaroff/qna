class Question < ApplicationRecord
  has_many :answers
  has_many :attachments
  accepts_nested_attributes_for :attachments

  validates :title, :body, presence: true
end
