class ActivityLog < ApplicationRecord
belongs_to :baby
belongs_to :assistant
belongs_to :activity
validate :stop_time_cannot_be_in_the_past
validates_datetime :start_time, :invalid_datetime_message  =>  "Invalid Date Time Format"
  def stop_time_cannot_be_in_the_past
    if stop_time.present? && stop_time < start_time
      errors.add(:stop_time, "can't be in the past")
    end
  end
end
