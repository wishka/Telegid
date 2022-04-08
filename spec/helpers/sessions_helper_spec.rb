require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the SessionHelper. For example:
#
# describe SessionHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe SessionsHelper, type: :helper do

  it "current_customer returns right user when session is nil" do
    assert_equal @customer, current_customer
    assert is_logged_in?
  end

  it "current_customer returns nil when remember digest is wrong" do
    @customer.update(:remember_digest, Customer.digest(Customer.new_token))
    assert_nil current_customer
  end
end
