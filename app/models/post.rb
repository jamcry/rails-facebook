class Post < ApplicationRecord
  belongs_to :user
  has_many   :comments, dependent: :destroy

  validates :body, presence: true, length: { maximum: 500 }

  scope :feed, -> { order(created_at: :desc) }
end
