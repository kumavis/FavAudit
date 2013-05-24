class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :fav_color
      t.string :fav_food

      t.timestamps
    end
  end
end
