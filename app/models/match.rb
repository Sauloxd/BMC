class Match < ApplicationRecord
  belongs_to :match_series
  belongs_to :player_a_1, class_name: "User"
  belongs_to :player_a_2, class_name: "User"
  belongs_to :player_b_1, class_name: "User"
  belongs_to :player_b_2, class_name: "User"


  validate :unique_players_on_match
  validate :at_least_one_adversary
  validate :score_in_set_bounds

  private

  def unique_players_on_match
    players = {
      player_a_1: player_a_1_id, 
      player_a_2: player_a_2_id, 
      player_b_1: player_b_1_id,
      player_b_2: player_b_2_id
  }.compact.group_by { |k,v| v }.select {|k,v| v.length > 1}
    players.each do |k,v|
      v.each do |player|
        errors.add(player.first, :unique_players_on_match, message: "Players must be unique! ID: #{player.second}") 
      end
    end
  end

  def at_least_one_adversary
    if player_a_1_id.present? || player_a_2_id.present? 
      errors.add(:at_least_one_adversary, 'Match should have at least one adversary!') if [player_b_1_id, player_b_2_id].compact.empty?
    end
    if player_b_1_id.present? || player_b_2_id.present?
      errors.add(:at_least_one_adversary, 'Match should have at least one adversary!') if [player_a_1_id, player_a_2_id].compact.empty?
    end
  end

  def score_in_set_bounds
    return if (0 <= score_a && score_a <= 7) && (0 <= score_b && score_b <= 7)
  end
end
