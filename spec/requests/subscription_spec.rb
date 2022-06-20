require 'rails_helper'

RSpec.describe "Subscriptions", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/subscription/new"
      expect(response).to have_http_status(:success)
    end
  end

end
