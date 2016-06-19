class CreateTituloLargos < ActiveRecord::Migration
  def change
    create_table :titulo_largos do |t|
      t.string :titulo

      t.timestamps null: false
    end
  end
end
