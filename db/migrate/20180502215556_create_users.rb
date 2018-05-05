class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username, null: false
      t.string :password, null: false
      t.string :first_name
      t.string :last_name

      t.timestamps null: false
    end
  end
end
