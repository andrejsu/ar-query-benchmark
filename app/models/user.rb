class User < ApplicationRecord
  has_one :user_profile, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_and_belongs_to_many :roles, join_table: :user_roles

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password_hash, presence: true
end
