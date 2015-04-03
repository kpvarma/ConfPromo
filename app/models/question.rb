class Question < ActiveRecord::Base

  attr_accessor :choice_1, :choice_2, :choice_3, :choice_4, :answer

  # Validations
  extend PoodleValidators
  validate_string :title, mandatory: true, format: /.*/i, max_length: 256
  validate_string :description, mandatory: true, format: /.*/i, max_length: 2048

  # Associations
  has_many :choices, dependent: :destroy

  # Callbacks
  after_find :assign_choices_and_answers

  # ------------------
  # Class Methods
  # ------------------

  # return an active record relation object with the search query in its where clause
  # Return the ActiveRecord::Relation object
  # == Examples
  #   >>> question.search(query)
  #   => ActiveRecord::Relation object
  scope :search, lambda {|query| where("LOWER(title) LIKE LOWER('%#{query}%') OR\
                                        LOWER(description) LIKE LOWER('%#{query}%')")
                        }

  # -----------------
  # Instance Methods
  # -----------------
  def add_choice(text)
    choice = Choice.new(text: text, question: self)
    choice.save
  end

  def remove_all_choices
    choices.destroy_all
  end

  def set_answer(text)
    choices.update_all(answer: false)
    choices.where("text = ?", text).update_all(answer: true)
  end

  def answer
    choices.where(answer: true).first
  end

  def assign_choices_and_answers
    begin
      self.choice_1 = self.choices[0].text if self.choices[0]
      self.choice_2 = self.choices[1].text if self.choices[1]
      self.choice_3 = self.choices[2].text if self.choices[2]
      self.choice_4 = self.choices[3].text if self.choices[3]
      self.answer = self.answer.text if self.answer
    else
    end
  end

end
