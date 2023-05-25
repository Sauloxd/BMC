class CreateMatches < ActiveRecord::Migration[7.0]
  def change
    create_table :matches do |t|
      t.references :match_series, foreign_key: true
      t.integer :score_a
      t.integer :score_b
      t.integer :score_tiebreak_a
      t.integer :score_tiebreak_b
      t.datetime :played_at, null: false

      t.references :player_a_1, foreign_key: { to_table: 'users' }
      t.references :player_a_2, foreign_key: { to_table: 'users' }
      t.references :player_b_1, foreign_key: { to_table: 'users' }
      t.references :player_b_2, foreign_key: { to_table: 'users' }

      t.timestamps
    end
  end
end
