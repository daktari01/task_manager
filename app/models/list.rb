class List < ApplicationRecord
  validates :title, presence: true, length: { maximum: 255 }
  
  before_validation :normalize_title
  before_destroy :check_for_incomplete_tasks
  
  scope :ordered, -> { order(created_at: :desc) }
  scope :with_incomplete_tasks, -> { joins(:tasks).where(tasks: { completed: false }).distinct }

  has_many :tasks, -> { order(position: :asc) }, dependent: :destroy



  def completion_summary
    total = tasks.loaded? ? tasks.size : tasks.count
    return 'No tasks yet' if total.zero?
    
    completed = if tasks.loaded?
                  tasks.count(&:completed?)
                else
                  tasks.completed.count
                end
    
    "#{completed}/#{total} tasks completed"
  end

  def percent_complete
    total = tasks.loaded? ? tasks.size : tasks.count
    return 0 if total.zero?
    
    completed = if tasks.loaded?
                  tasks.count(&:completed?)
                else
                  tasks.completed.count
                end
    
    ((completed.to_f / total) * 100).round
  end
  
  private
  
  def normalize_title
    self.title = title.to_s.strip.titleize if title.present?
  end
  
  def check_for_incomplete_tasks
    if tasks.pending.any?
      errors.add(:base, 'Cannot delete list with incomplete tasks')
      throw :abort
    end
  end
end
