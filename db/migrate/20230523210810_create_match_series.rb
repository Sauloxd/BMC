class CreateMatchSeries < ActiveRecord::Migration[7.0]
  def change
    create_table :match_series do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
