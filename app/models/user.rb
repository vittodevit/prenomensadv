class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Enum for roles
  enum :role, { tutor: "tutor", student: "student" }

  # relationship with requests
  has_many :requests

  # Validate password
  validates :password, presence: true
  validates :password, format: { with: /\d/, message: "deve includere almeno un numero" }

  # Add validations for name and surname
  validates :name, :surname, presence: true

  def active_for_authentication?
    tutor? || (student? && approved_from_tutor?)
  end

  # Custom message for unapproved students
  def inactive_message
    if student? && !approved_from_tutor?
      :not_approved
    else
      super
    end
  end

  before_validation :set_default_role, on: :create

  private

  def set_default_role
    self.role ||= "student"
    self.approved_from_tutor ||= false
  end


end
