require 'rails_helper'

RSpec.describe Choice, type: :model do

  context "Factory" do
    it "should validate all the choice factories" do
      expect(FactoryGirl.build(:choice).valid?).to be true
    end
  end

  context "Validations" do
    it { should validate_presence_of :text }
    it { should allow_value('What would be the output of the following?').for(:text )}
    it { should_not allow_value('KP').for(:text )}
    it { should_not allow_value("x"*513).for(:text )}

    it { should validate_presence_of :question }
  end

  context "Associations" do
    it { should belong_to(:question) }
  end


end
