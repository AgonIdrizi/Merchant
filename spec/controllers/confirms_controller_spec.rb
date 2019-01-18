require 'rails_helper'

RSpec.describe ConfirmsController, type: :controller do

  describe "GET #new" do
    xit "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #create" do
    xit "returns http success" do
      post :create
      expect(response).to have_http_status(:success)
    end
  end

end
