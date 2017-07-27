require 'test_helper'
class MicropostTest < ActiveSupport::TestCase
  def setup
    @user = users(:furuhama)
    # このコードは慣習的に正しくない　らしい
    @micropost = Micropost.new(content: "Lorem ipsum", user_id: @user.id)
  end

  test "should be valid" do
    assert @micropost.valid?
  end

  test "user id should be present" do
    @micropost.user_id = nil
    assert_not @micropost.valid?
  end
end
