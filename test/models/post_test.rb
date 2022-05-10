require "test_helper"

class PostTest < ActiveSupport::TestCase
  def setup
    @customer = customers(:michael)
    # Этот код идиоматически не корректен.
    @post = Post.new(content: "Lorem ipsum", customer_id: @customer.id)
  end

  test "should be valid" do
    assert @post.valid?
  end

  test "customer id should be present" do
    @customer.customer_id = nil
    assert_not @post.valid?
  end
end
