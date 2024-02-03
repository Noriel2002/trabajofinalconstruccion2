class CreateLinks < ActiveRecord::Migration[7.1]
  def change
      create_table :links do |t|
        t.string :slug 
        t.string :name
        t.string :url
        t.string  :url_short
        t.string :link_type
        t.references :user, foreign_key: true
        t.string :password # Para enlaces privados
        t.datetime :expiration_date # Para enlaces temporales

      t.timestamps
    end
    add_index :links, :slug, unique: true # Agregar un índice único para el slug
  
  end
end
