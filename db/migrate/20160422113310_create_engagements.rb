class CreateEngagements < ActiveRecord::Migration
  def change
    create_table :engagements do |t|
      t.text :post_content
      t.string :post_file
      t.timestamps null: false
    end
  end
end
