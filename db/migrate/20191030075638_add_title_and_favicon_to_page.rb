class AddTitleAndFaviconToPage < ActiveRecord::Migration[5.2]
  def change
    add_column :pages, :title, :string
    add_column :pages, :favicon_path, :string
  end
end
