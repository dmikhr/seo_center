class CreateLinks < ActiveRecord::Migration[5.2]
  def change
    create_table :links do |t|
      t.references :page, foreign_key: true
      t.string :anchor
      t.string :url
      t.boolean :internal

      t.timestamps
    end
  end
end
