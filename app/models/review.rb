class Review < ApplicationRecord
  belongs_to :article
  belongs_to :user

  validates :review, presence: true
end
