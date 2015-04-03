require 'rails_helper'
RSpec.describe User, :type => :model do

  let(:user1) {FactoryGirl.create(:user, name: "Ram", email: "ram@yopmail.com")}
  let(:user2) {FactoryGirl.create(:user, name: "Lakshman", email: "lakshman@yopmail.com")}
  let(:user3) {FactoryGirl.create(:user, name: "Sita", email: "sita@yopmail.com")}

  context "Factory" do
    it "should validate all the user factories" do
      expect(FactoryGirl.build(:user).valid?).to be true
    end
  end

  context "Validations" do
    it { should validate_presence_of :name }
    it { should allow_value('Krishnaprasad Varma').for(:name )}
    it { should_not allow_value('KP').for(:name )}
    it { should_not allow_value("x"*257).for(:name )}

    it { should validate_presence_of :email }
    it { should allow_value('something@domain.com').for(:email )}
    it { should_not allow_value('something domain.com').for(:email )}
    it { should_not allow_value('something.domain.com').for(:email )}
    it { should_not allow_value('ED').for(:email )}
    it { should_not allow_value("x"*257).for(:email )}

    it { should validate_presence_of :password }
    it { should allow_value('Password@1').for(:password )}
    it { should_not allow_value('password').for(:password )}
    it { should_not allow_value('password1').for(:password )}
    it { should_not allow_value('password@1').for(:password )}
    it { should_not allow_value('ED').for(:password )}
    it { should_not allow_value("a"*257).for(:password )}
  end

  context "Associations" do
    it { should have_many(:uanswers) }
  end

  context "Class Methods" do
    it "search" do
      arr = [user1, user2, user3]
      expect(User.search("Ram")).to match_array([user1])
      expect(User.search("Lakshman")).to match_array([user2])
      expect(User.search("Sita")).to match_array([user3])
      expect(User.search("yopmail")).to match_array([user1, user2, user3])
    end
  end
end

