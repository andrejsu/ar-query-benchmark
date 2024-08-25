class UserProfile < ApplicationRecord
  belongs_to :user

  validates :first_name, :last_name, presence: true
  validates :phone_number, length: { maximum: 30 }
end
