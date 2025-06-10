class List < ApplicationRecord
  validates :title, presence: true, length: { maximum: 255 }
  
  scope :ordered, -> { order(created_at: :desc) }

  has_many :tasks, dependent: :destroy

  def completion_summary
    total = tasks.count
    return if total.zero?
    
    completed = tasks.completed.count
    "#{completed}/#{total} tasks completed"
  end
end
