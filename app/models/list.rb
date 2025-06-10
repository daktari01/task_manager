class List < ApplicationRecord
  validates :title, presence: true, length: { maximum: 255 }
  
  scope :ordered, -> { order(created_at: :desc) }

  has_many :tasks
end
