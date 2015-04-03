require 'rails_helper'

describe Users::DashboardController, :type => :controller do

  let(:user) {FactoryGirl.create(:user)}

  describe "index" do

    context "positive case" do
      it "should display the dashboard" do
        get :index, {}, {id: user.id}
        expect(assigns(:current_user)).to eq(user)
        expect(response.status).to eq(200)
      end
    end

    context "negative case" do
      it "should redirect to sign in page page if already signed in" do
        get :index, {}, {}
        expect(response.status).to eq(302)
        expect(response).to redirect_to("/sign_in")
      end
    end
  end

end
