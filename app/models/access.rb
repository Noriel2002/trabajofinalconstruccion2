class Access < ApplicationRecord
    belongs_to :link
  
    validates :ip_address, presence: true
  
    scope :by_date_range, ->(start_date, end_date) {
      where(created_at: start_date.beginning_of_day..end_date.end_of_day)
    }
  end
  