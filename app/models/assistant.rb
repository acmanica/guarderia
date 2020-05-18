class Assistant < ApplicationRecord
has_many :activity_logs
validates :group, presence: true
validates :name, presence: true
end
