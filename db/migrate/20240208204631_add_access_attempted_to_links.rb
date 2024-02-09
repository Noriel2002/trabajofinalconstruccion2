class AddAccessAttemptedToLinks < ActiveRecord::Migration[7.1]
  def change
    add_column :links, :access_attempted, :boolean
  end
end
