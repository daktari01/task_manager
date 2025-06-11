class List < ApplicationRecord
  validates :title, presence: true, length: { maximum: 255 }
  
  before_validation :normalize_title
  
  scope :ordered, -> { order(created_at: :desc) }

  has_many :tasks, -> { order(position: :asc) }, dependent: :destroy

  def completion_summary
    total = tasks.count
    return 'No tasks yet' if total.zero?
    
    completed = tasks.completed.count
    "#{completed}/#{total} tasks completed"
  end
  
  private
  
  def normalize_title
    self.title = title.to_s.strip.titleize if title.present?
  end
end
