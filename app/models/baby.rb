class Baby < ApplicationRecord
has_many :activity_logs
validates :birthday, presence: true
validates :name, presence: true
validates_date :birthday, :invalid_date_message  =>  "Invalid Date Format"
end
