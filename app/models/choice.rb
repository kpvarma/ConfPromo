class Choice < ActiveRecord::Base

  # Validations
  extend PoodleValidators
  validate_string :text, mandatory: true, format: /.*/i, max_length: 512
  validates :question, presence: true

  # Associations
  belongs_to :question

end
