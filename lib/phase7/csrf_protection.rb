class CSRFProtection
  attr_reader :form_authenticity_token

  def initialize
    @form_authenticity_token = SecureRandom.urlsafe_base64(16)
  end

  def confirm_authenticity_token(token)
    # gathered via params[authenticity_token]
    raise InvalidAuthenticityToken unless token == form_authenticity_token
    # we raise an error - or alternately, we could signout the user
  end
end

class InvalidAuthenticityToken < StandardError
end


# when program starts, we assign the form token
# when programmer writes the form:
#   name = 'authenticity_token' which gets saved to params[authenticity_token]
#   value = 'form_authenticity_token' which is the form token we generated
