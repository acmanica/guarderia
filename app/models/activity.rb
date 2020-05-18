class Activity < ApplicationRecord
  has_many :activity_logs
  validates :name, presence: true
  validates :description, presence: true
end
