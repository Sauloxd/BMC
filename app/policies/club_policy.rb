class ClubPolicy < ApplicationPolicy
  def update?
    record.owner.id == user.id
  end
end