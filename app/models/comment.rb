class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :micropost
  default_scope -> { order(created_at: :desc) }
  validates :micropost_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
end
