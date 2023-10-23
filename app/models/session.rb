class Session < ApplicationRecord
  belongs_to :user

  validates :location, presence: true
  validates :date, presence: true
  validates :description, presence: true
end
