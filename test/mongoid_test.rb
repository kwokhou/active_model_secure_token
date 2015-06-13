require "test_helper"

class MongoidSecureTokenTest < MiniTest::Unit::TestCase
  def setup
    @post = Post.new
  end

  def teardown
    Mongoid.purge!
  end

  def test_token_values_are_generated_for_specified_attributes_and_persisted_on_save
    @post.save
    refute_nil @post.token
    refute_nil @post.auth_token
  end

  def test_regenerating_the_secure_token
    @post.save
    old_token = @post.token
    old_auth_token = @post.auth_token
    @post.regenerate_token
    @post.regenerate_auth_token

    refute_equal @post.token, old_token
    refute_equal @post.auth_token, old_auth_token
  end

  def test_token_value_not_overwritten_when_present
    @post.token = "custom-secure-token"
    @post.save

    assert_equal @post.token, "custom-secure-token"
  end
end
