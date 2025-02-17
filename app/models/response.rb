class Response < ApplicationRecord
  belongs_to :user
  belongs_to :request
  serialize :dates, type: Array, coder: JSON

  validates :user_id, presence: true
  validates :request_id, presence: true
  validates :days, presence: true

  def present_on?(date)
    (days || []).include?(date.to_s)
  end
end
