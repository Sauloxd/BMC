class MatchSeries < ApplicationRecord
  has_many :match_series_participations, dependent: :destroy

  validates :name, presence: true

  def count
    match_series_participations.count
  end
end
