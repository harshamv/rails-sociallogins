class CreateInfluencers < ActiveRecord::Migration
  def change
    create_table :influencers do |t|
      t.string :first_name, null: false
      t.string :last_name
      t.string :username
      t.string :profile_picture_url
      t.string :email
      t.string :bio
      t.string :location
      t.string :gender
      t.date :date_of_birth
      t.string :no_of_friends
      t.string :time_zone_name, default: 'Asia/Kolkata', null: false
      t.integer :status, default: 1, null: false
      t.datetime :deleted_at
      t.timestamps null: false
    end
  end
end
