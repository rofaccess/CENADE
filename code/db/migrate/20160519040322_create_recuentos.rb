class CreateRecuentos < ActiveRecord::Migration
  def change
    create_table :recuentos do |t|
      t.belongs_to :consulta_nutricional_adulto , null: false
      t.string  :comidas_turnos                 ,limit: Domain::DESC50
      t.string  :hora                           ,limit: Domain::DESC10,   null: true
      t.string  :alimentos                      ,limit: Domain::DESC250,   null: true
      t.integer :cantidad                       ,limit: Domain::CANT_COMIDA,   null: true
      t.string  :modo_preparacion               ,limit: Domain::DESC500,   null: true
      t.string  :lugar_consumo                  ,limit: Domain::DESC200,   null: true

      t.timestamps null: false
    end

    add_index :recuentos, :consulta_nutricional_adulto_id, name: "consulta_id"
  end
end
