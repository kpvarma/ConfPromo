require 'rails_helper'

describe Public::UserSessionsController, :type => :controller do

  let(:user) {FactoryGirl.create(:user)}

  describe "sign_in" do

    context "positive case" do
      it "should display the sign in form" do
        get :sign_in, {}, {}
        expect(response.status).to eq(200)
      end
    end

    context "negative case" do
      it "should redirect to dashboard page if already signed in" do
        get :sign_in, {}, {id: user.id}
        expect(response.status).to eq(302)
        expect(response).to redirect_to("/users/dashboard")
      end
    end
  end

  describe "create_session" do

    context "positive case" do
      it "should create session with email" do
        sign_in_params = { email: user.email, password: user.password }
        post :create_session, sign_in_params, {}
        expect(session[:id].to_s).to  eq(user.id.to_s)
        expect(assigns(:current_user)).to eq(user)
        expect(response.status).to eq(302)
        expect(response).to redirect_to("/users/dashboard")
      end
    end

    context "negative case" do
      it "invalid email" do
        sign_in_params = { email: "invalid@email.com" }
        post :create_session, sign_in_params, {}
        expect(session[:id]).to be_nil
        expect(assigns(:current_user)).to be_nil
        expect(response.status).to eq(302)
        expect(response).to redirect_to("/sign_in")
      end

      it "invalid password" do
        sign_in_params = { email: user.email, password: "Invalid" }
        post :create_session, sign_in_params, {}
        expect(session[:id]).to be_nil
        expect(assigns(:current_user)).to be_nil
        expect(response.status).to eq(302)
        expect(response).to redirect_to("/sign_in")
      end
    end

    context "already logged in case" do
      it "should redirect to dashboard page if already signed in" do
        sign_in_params = { email: user.email, password: user.password }
        post :create_session, sign_in_params, {id: user.id}
        expect(response.status).to eq(302)
        expect(response).to redirect_to("/users/dashboard")
      end
    end
  end

  describe "destroy a session" do
    context "positive case" do
      it "should delete session of user" do
        delete :sign_out, {:id => user.id}, {id: user.id}
        expect(session[:id]).to be_nil
        expect(assigns(:current_user)).to be_nil
        expect(response.status).to eq(302)
        expect(response).to redirect_to("/sign_in")
      end
    end

    context "negative case" do
      it "should redirect to sign in page if session is expired" do
        delete :sign_out, {:id => user.id}, {id: nil}
        expect(response.status).to eq(302)
        expect(response).to redirect_to("/sign_in")
      end
    end
  end
end
