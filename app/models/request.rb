class Request < ApplicationRecord
  belongs_to :user
  serialize :dates, type: Array, coder: JSON
  has_many :responses, dependent: :destroy
  validates :due_date, presence: true
  validates :dates, presence: true
end
