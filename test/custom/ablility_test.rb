class BadgeTest < ActiveSupport::TestCase
  test 'read_graph' do
    user = User.create!
    ability = Ability.new(user)
    assert ability.can?(:read, :graph)
  end
end