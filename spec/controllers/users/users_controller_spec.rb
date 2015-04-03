require 'rails_helper'

describe Users::UsersController, :type => :controller do

  let(:user_1) {FactoryGirl.create(:user)}
  let(:user_2) {FactoryGirl.create(:user)}
  let(:user_3) {FactoryGirl.create(:user)}

  let(:valid_user_params) { {user: FactoryGirl.build(:user).as_json} }
  let(:invalid_user_params) { {user: {}} }

  context "index" do
    it "should return the list of users" do
      arr = [user_1, user_2, user_3]
      get :index, nil, {id: user_1.id}
      expect(assigns[:users]).to match_array(arr)
      expect(response.status).to eq(200)

      xhr :get, :index, {}, {id: user_1.id}
      expect(assigns[:users]).to match_array(arr)
      expect(response.code).to eq("200")
    end
  end

  context "show" do
    it "should return a specific user" do
      arr = [user_1,user_2, user_3]
      get :show, {:id => user_1.id}, {id: user_1.id}
      expect(assigns[:user]).to eq(user_1)
      expect(assigns[:users]).to match_array(arr)
      expect(response.status).to eq(200)

      xhr :get, :show, {id: user_1.id}, {id: user_1.id}
      expect(assigns[:user]).to eq(user_1)
      expect(response.code).to eq("200")
    end
  end

  context "new" do
    it "should display the form" do
      arr = [user_1,user_2, user_3]
      get :new, {}, {id: user_1.id}
      expect(assigns[:users]).to match_array(arr)
      expect(response.status).to eq(200)

      xhr :get, :new, {}, {id: user_1.id}
      expect(assigns(:user)).to be_a User
    end
  end

  context "create" do
    it "positive case" do
      xhr :post, :create, valid_user_params, {id: user_1.id}
      expect(User.count).to  eq 2
      expect(response.code).to eq("200")
    end

    it "negative case" do
      xhr :post, :create, invalid_user_params, {id: user_1.id}
      expect(User.count).to  eq 1
      expect(response.code).to eq("200")
    end
  end

  context "edit" do
    it "should display the form" do
      arr = [user_1,user_2, user_1]
      get :edit, {id: user_1.id}, {id: user_1.id}
      expect(assigns[:users]).to match_array(arr)
      expect(assigns[:user]).to eq(user_1)
      expect(response.status).to eq(200)

      xhr :get, :edit, {id: user_1.id}, {id: user_1.id}
      expect(assigns(:user)).to eq(user_1)
      expect(response.code).to eq("200")
    end
  end

  context "update" do
    it "positive case" do
      xhr :put, :update, {id: user_1.id, user: user_1.as_json.merge!({"name" =>  "Updated Name"})}, {id: user_1.id}
      expect(assigns(:user).errors.any?).to eq(false)
      expect(assigns(:user).name).to  eq("Updated Name")
      expect(response.code).to eq("200")
    end

    it "negative case" do
      xhr :put, :update, {id: user_1.id, user: user_1.as_json.merge!({"name" =>  ""})}, {id: user_1.id}
      expect(assigns(:user).errors.any?).to eq(true)
      expect(response.code).to eq("200")
    end
  end

  context "destroy" do
    it "should remove the user" do
      xhr :delete, :destroy, {id: user_1.id}, {id: user_1.id}
      expect(User.count).to  eq 1
      expect(response.code).to eq("200")
    end
  end

end
