class CreateApiCalls < ActiveRecord::Migration
  def change
    create_table :api_calls do |t|
      t.string :api_call_return_value

      t.timestamps null: false
    end
  end
end
