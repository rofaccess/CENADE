class CreateReportesEstadisticos < ActiveRecord::Migration
  def change
    create_table :reportes_estadisticos do |t|
      t.integer :area_id			,null:false
      t.string :mes					  ,limit: Domain::DESC10,	  null:false
      t.integer :anho				  ,limit: Domain::ANHO,	  null:false
      t.integer :doctor_id		,null:false
      t.integer :cantidad

      t.timestamps null: false
    end
	add_foreign_key(:reportes_estadisticos, :areas, column: 'area_id', on_delete: :restrict)

	add_index :reportes_estadisticos, :doctor_id
	add_index :reportes_estadisticos, :area_id

  end
end
