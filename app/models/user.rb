class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  scope :by_email, -> (email) { where("email ILIKE ?", "%#{email}%") }
  scope :in_match_series, -> (match_series_id) { where(id: MatchSeries.find(match_series_id).match_series_participations.pluck(:user_id)) }
end
