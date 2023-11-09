module OpenAi
  module Errors
    JSONParseError             = Class.new(StandardError)
    RecordNotFoundError        = Class.new(StandardError)
    LinkNotFoundError          = Class.new(StandardError)
    InvalidRequestError        = Class.new(StandardError)
    InvalidArgumentError       = Class.new(StandardError)
    InvalidFileError           = Class.new(StandardError)
    InvalidFilePathError       = Class.new(StandardError)
    InvalidMimeTypeError       = Class.new(StandardError)
    InvalidAuthenticationError = Class.new(StandardError)
    MissingUnitDefinitionError = Class.new(StandardError)
    MissingTimezoneError       = Class.new(StandardError)
    MissingCurrencyCodeError   = Class.new(StandardError)
    MissingIdError             = Class.new(StandardError)
  end
end
