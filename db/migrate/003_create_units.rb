class CreateUnits < ActiveRecord::Migration[5.1]
  def change
    create_table :units do |t|
      t.string  :name
      t.string  :user_password

      t.timestamps
    end
  end
end
