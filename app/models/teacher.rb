class Teacher < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  after_initialize :set_default_role, :if => :new_record?
  enum role: [:normal, :admin]
  has_many :locations, dependent: :destroy
  has_many :schedules

  scope :has_location, -> { joins(:locations).where('locations')}

  def set_default_role
    self.role ||= :normal
  end

  def active_for_authentication?
    super && approved?
  end

  def inactive_message
    approved? ? super : :not_approved
  end
end
