class CreateHtags < ActiveRecord::Migration[5.2]
  def change
    create_table :htags do |t|
      t.references :page, foreign_key: true
      t.integer :level
      t.string :contents

      t.timestamps
    end
  end
end
