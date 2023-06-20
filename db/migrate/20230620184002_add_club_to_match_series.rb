class AddClubToMatchSeries < ActiveRecord::Migration[7.0]
  def change
    add_reference :match_series, :club, null: false, foreign_key: true
  end
end
