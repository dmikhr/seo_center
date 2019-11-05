class CreatePages < ActiveRecord::Migration[5.2]
  def change
    create_table :pages do |t|
      t.references :website, foreign_key: true
      t.string :path
      t.string :contents

      t.timestamps
    end
  end
end
