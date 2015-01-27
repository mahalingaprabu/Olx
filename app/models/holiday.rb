class Holiday < ActiveRecord::Base
  attr_accessible :holiday_day, :holiday_date, :holiday_reason, :holiday_type
  validates_presence_of :holiday_reason, :message => "Holiday reason cannot be blank"
end
