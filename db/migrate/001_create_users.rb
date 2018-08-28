class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.belongs_to  :unit
      t.string      :first_name
      t.string      :last_name
      t.boolean	    :active, default: true
      t.boolean     :admin, default: false
      t.boolean     :super_admin, default: false

      t.timestamps
    end
  end
end
