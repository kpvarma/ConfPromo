FactoryGirl.define do
  factory :question do
    title "This is a question title"
    description "This is a question description"
  end

  factory :question_with_options, parent: :question do
    after(:create) do |q|
      # Create 4 Choices, one as the answer
      q.add_choice("Option 1")
      q.add_choice("Option 2")
      q.add_choice("Option 3", true)
      q.add_choice("Option 4")
    end
  end
end
