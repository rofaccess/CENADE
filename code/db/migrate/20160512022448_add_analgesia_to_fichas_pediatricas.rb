class AddAnalgesiaToFichasPediatricas < ActiveRecord::Migration
  def change
  	add_column :fichas_pediatricas, :analgesia, :string, null: true, default: '',limit: Domain::DESC50
  end
end
