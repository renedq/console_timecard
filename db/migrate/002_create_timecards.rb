class CreateTimecards < ActiveRecord::Migration[5.1]
  def change
    create_table :timecards do |t|
      t.belongs_to  :user
      t.datetime    :start_time
      t.decimal     :hours

      t.timestamps
    end
  end
end
