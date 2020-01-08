class ScheduledStudent < ApplicationRecord
  enum status: [:pending, :active, :archived]
  belongs_to :student
  has_many :schedules, dependent: :destroy
  #before_create :check_self_status
  #
  #def check_self_status
  #  if self.schedules.any?
  #    self.schedules.each do |s|
  #      if s.active?
  #        self.status = "active"
  #      end
  #    end
  #  end
  #end
end
