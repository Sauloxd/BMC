class MatchSeriesParticipation < ApplicationRecord
  belongs_to :match_series
  belongs_to :user
end
