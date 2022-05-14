class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :name, null: false
      t.string :content, null: false

      t.timestamps
    end
  end
end
