class User < ActiveRecord::Base

  # including Password Methods
  has_secure_password

  # FIXME: Not sure if we need rolify
  rolify

  # Constants
  DEFAULT_PASSWORD = "Password@1"

  # Validations
  extend PoodleValidators
  validate_string :name, mandatory: true
  validate_email :email
  validate_password :password, condition_method: :should_validate_password?

  # Associations
  has_many :uanswers

  # ------------------
  # Class Methods
  # ------------------

  # return an active record relation object with the search query in its where clause
  # Return the ActiveRecord::Relation object
  # == Examples
  #   >>> user.search(query)
  #   => ActiveRecord::Relation object
  scope :search, lambda {|query| where("LOWER(name) LIKE LOWER('%#{query}%') OR\
                                        LOWER(email) LIKE LOWER('%#{query}%')")
                        }

  # ------------------
  # Instance Methods
  # ------------------

  def assign_default_password_if_nil
    self.password = DEFAULT_PASSWORD
    self.password_confirmation = DEFAULT_PASSWORD
  end

  private

  def should_validate_password?
    self.new_record? || (self.new_record? == false and self.password.present?)
  end



end
