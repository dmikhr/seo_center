class CreateMetas < ActiveRecord::Migration[5.2]
  def change
    create_table :metas do |t|
      t.references :page, foreign_key: true
      t.string :description
      t.string :author
      t.string :encoding
      t.string :keywords

      t.timestamps
    end
  end
end
