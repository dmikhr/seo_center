class AddUserToWebsite < ActiveRecord::Migration[5.2]
  def change
    add_reference :websites, :user, foreign_key: true
  end
end
