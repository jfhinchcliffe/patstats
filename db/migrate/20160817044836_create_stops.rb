class CreateStops < ActiveRecord::Migration
  def change
    create_table :stops do |t|
      t.string :routes_serviced
      t.string :stop_name
      t.string :operator
      t.string :diva_id
      t.integer :mode
      t.boolean :currently_checked

      t.timestamps null: false
    end
  end
end
