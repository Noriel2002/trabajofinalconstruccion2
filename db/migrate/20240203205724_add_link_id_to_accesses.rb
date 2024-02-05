class AddLinkIdToAccesses < ActiveRecord::Migration[7.1]
  def change
    add_reference :accesses, :link, null: false, foreign_key: true
  end
end
