class CreateImages < ActiveRecord::Migration[5.2]
  def change
    create_table :images do |t|
      t.references :page, foreign_key: true
      t.string :src
      t.string :alt

      t.timestamps
    end
  end
end
