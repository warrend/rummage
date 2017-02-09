class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.string :name 
      t.string :location
      t.text :description
      t.integer :tag_id
      t.integer :user_id
    end 
  end
end
