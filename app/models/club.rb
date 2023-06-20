class Club < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :match_series, dependent: :destroy
  belongs_to :owner, class_name: 'User'

  scope :has_user, -> (user_id) { Club.where(id: Membership.select(:club_id).where(user_id: user_id).distinct ) }

  def count
    memberships.count
  end
end
