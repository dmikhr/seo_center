class AddRobotsTxt < ActiveRecord::Migration[5.2]
  def change
    add_column :websites, :robots_txt, :string
  end
end
