class CreateInfluencerAuthorizations < ActiveRecord::Migration
  def change
    create_table :influencer_authorizations do |t|
      t.string :provider, null: false
      t.string :provider_uid, null: false
      t.text :oauth_token, null: false
      t.text :meta
      t.integer :influencer_id, null: false
      t.string :social_account
      t.datetime :deleted_at
      t.timestamps null: false
    end

    add_index :influencer_authorizations, :influencer_id
  end
end
