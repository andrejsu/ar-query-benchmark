class CreateUserProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :user_profiles do |t|
      t.references :user, null: false, foreign_key: true, unique: true
      t.string :first_name
      t.string :last_name
      t.text :address
      t.string :phone_number
      t.timestamps
    end
  end
end
