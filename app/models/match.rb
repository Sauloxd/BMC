class Match < ApplicationRecord
  belongs_to :match_series
  belongs_to :player_a_1, class_name: "User"
  belongs_to :player_a_2, class_name: "User"
  belongs_to :player_b_1, class_name: "User"
  belongs_to :player_b_2, class_name: "User"
end
