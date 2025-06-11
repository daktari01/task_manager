class Task < ApplicationRecord
  belongs_to :list
  validates :title, presence: true, length: { maximum: 255 }

  before_validation :set_default_position, on: :create
  before_save :normalize_title

  scope :completed, -> { where(completed: true) }
  scope :pending, -> { where(completed: false) }
  scope :ordered, -> { order(position: :asc, created_at: :asc) }

  private

  def set_default_position
    return if position.present?
    
    if list.tasks.loaded?
      max_position = list.tasks.reject { |t| t == self }.map(&:position).max || -1
      self.position = max_position + 1
    else
      self.position = (list.tasks.maximum(:position) || -1) + 1
    end
  end

  def normalize_title
    self.title = title.to_s.strip.titleize
  end
end