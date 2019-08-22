class CreateUsers < ActiveRecord::Migration[5.2]
  
  def change
      create_table :users do |t|
          t.string :username
          t.string :password
          t.integer :score, default: 0
          #t.integer :bonus_points, default: 0
          #t.boolean :bonus_point_check, default: false
      end
  end
  
end
