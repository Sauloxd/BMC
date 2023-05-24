class CreateMatchSeriesParticipations < ActiveRecord::Migration[7.0]
  def change
    create_table :match_series_participations do |t|
      t.references :match_series, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
