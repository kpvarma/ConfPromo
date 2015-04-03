require 'rails_helper'
RSpec.describe Question, :type => :model do

  let(:question_1) {FactoryGirl.create(:question, title: "Ruby", description: "Ruby is a programming langugage")}
  let(:question_2) {FactoryGirl.create(:question, title: "Ruby on Rails", description: "Ruby on Rails is a Framework built in Ruby programming langugage")}
  let(:question_3) {FactoryGirl.create(:question, title: "Python", description: "Python is a programming langugage")}
  let(:qwo) {FactoryGirl.create(:question_with_options)}

  context "Factory" do
    it "should validate all the question factories" do
      expect(FactoryGirl.build(:question).valid?).to be true
      expect(FactoryGirl.build(:question_with_options).valid?).to be true
    end
  end

  context "Validations" do
    it { should validate_presence_of :title }
    it { should allow_value('What would be the output of the following?').for(:title )}
    it { should_not allow_value('KP').for(:title )}
    it { should_not allow_value("x"*513).for(:title )}

    it { should validate_presence_of :description }
    it { should allow_value('x'*2048).for(:description )}
    it { should_not allow_value('xx').for(:description )}
    it { should_not allow_value("x"*2049).for(:description )}
  end

  context "Associations" do
    it { should have_many(:choices) }
  end

  context "Class Methods" do
    it "search" do
      arr = [question_1, question_2, question_3]
      expect(Question.search("Python")).to match_array([question_3])
      expect(Question.search("Ruby")).to match_array([question_1, question_2])
      expect(Question.search("programming langugage")).to match_array(arr)
      expect(Question.search("yopmail")).to match_array([])
    end
  end

  context "Instance Methods" do
    it "should add_choice and set_answer" do
      question_1.add_choice("Choice 1")
      question_1.add_choice("Choice 2")
      question_1.add_choice("Choice 3")
      question_1.add_choice("Choice 4")
      expect(question_1.choices.count).to eq(4)
      question_1.set_answer("Choice 2")
      expect(question_1.answer).to eq(question_1.choices.where(text: "Choice 2").first)
    end

    it "should remove_all_choices" do
      qwo.remove_all_choices
      expect(qwo.choices.count).to eq(0)
    end
  end
end

