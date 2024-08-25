class Role < ApplicationRecord
  has_and_belongs_to_many :users, join_table: :user_roles

  validates :role_name, presence: true, uniqueness: true
end
