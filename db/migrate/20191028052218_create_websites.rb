class CreateWebsites < ActiveRecord::Migration[5.2]
  def change
    create_table :websites do |t|
      t.string :url
      t.boolean :www
      t.boolean :https
      t.datetime :scanned_time

      t.timestamps
    end
  end
end
