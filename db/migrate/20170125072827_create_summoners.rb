class CreateSummoners < ActiveRecord::Migration
  def change
    create_table :summoners do |t|
      t.string :name
      t.integer :riot_id

      t.timestamps null: false
    end
  end
end
