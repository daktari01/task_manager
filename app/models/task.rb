class Task < ApplicationRecord
  belongs_to :list

  validates :title, presence: true, length: { maximum: 255 }
  scope :completed, -> { where(completed: true) }
  scope :pending, -> { where(completed: false) }
end
