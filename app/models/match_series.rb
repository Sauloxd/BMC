class MatchSeries < ApplicationRecord
  has_many :match_series_participations, dependent: :destroy
  has_many :matches, dependent: :destroy

  validates :name, presence: true

  def count
    match_series_participations.count
  end
end
