class EmailValidator < ActiveModel::EachValidator
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  def validate_each(record, attribute, email)
    record.errors.add(attribute, 'invalid mail') if invalid?(email)
  end

  def invalid?(email)
    EMAIL_REGEX !~ email
  end
end
