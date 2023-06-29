require "test_helper"

class ClubsControllerTest < ActionDispatch::IntegrationTest
  test "when not authenticated it should redirect to sign in" do
    get clubs_path

    assert_redirected_to new_user_session_url
  end

  test "render only clubs user has membership with" do
    user = users(:one)
    sign_in user
    membership = memberships(:one)
    membership.update!(user: user)
    
    get clubs_path
    assert_select "a[href=\"#{club_path(membership.club)}\"]", membership.club.name
    assert_select "#clubs_tbody tr", 1
  end

  test "creates club with logged user as owner" do
    user = users(:one)
    sign_in user

    assert_changes "Club.count", 1 do
      post clubs_path(format: :turbo_stream, club: { name: 'New Club!' })
    end
    assert_equal 'New Club!', Club.last.name
    assert_equal user.id, Club.last.owner_id
  end

  test "update club name and memberships when user is also owner" do
    club_one = clubs(:one)
    user_two = users(:two)
    sign_in club_one.owner

    assert_changes -> { club_one.memberships.first.user_id }, from: users(:one).id, to: users(:two).id do
      patch club_path(club_one), params: {
        format: :turbo_stream, 
        club: {
          name: 'Updated club name',
        },
        member_ids: [user_two.id]
      }
    end

    assert_equal 'Updated club name', club_one.reload.name
  end 
end
