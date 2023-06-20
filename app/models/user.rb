class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar
  has_many :matches, class_name: 'Match', foreign_key: :player_a_1_id
  has_many :matches, class_name: 'Match', foreign_key: :player_a_2_id
  has_many :matches, class_name: 'Match', foreign_key: :player_b_1_id
  has_many :matches, class_name: 'Match', foreign_key: :player_b_2_id

  scope :by_email, -> (email) { where("email ILIKE ?", "%#{email}%") }
  scope :in_match_series, -> (match_series_id) { where(id: MatchSeries.find(match_series_id).match_series_participations.pluck(:user_id)) }
  scope :in_club, ->(club_id) { where(id: Membership.select(:user_id).where(club_id: club_id) ) }

  validates :name, presence: true
end
