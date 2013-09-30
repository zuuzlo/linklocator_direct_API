require "linklocator_direct_API/version"

require "linklocator_direct_API/text_link"
require "linklocator_direct_API/response"

require "linklocator_direct_API/errors/error"
require "linklocator_direct_API/errors/authentication_error"
require "linklocator_direct_API/errors/connection_error"
require "linklocator_direct_API/errors/invalid_request_error"


module LinklocatorDirectAPI
  WEB_SERVICE_URIS = {
    text_link: "http://lld2.linksynergy.com/services/restLinks/getTextLinks"
  }

  @api_timeout = 30

  class << self
    attr_accessor :token
    attr_reader :api_timeout
  end

  def self.api_timeout=(timeout)
    raise ArgumentError, "Timeout must be a Fixnum; got #{timeout.class} instead" unless timeout.is_a? Fixnum
    raise ArgumentError, "Timeout must be > 0; got #{timeout} instead" unless timeout > 0
    @api_timeout = timeout
  end

  def self.text_link(options = {})
    text_link = LinklocatorDirectAPI::TextLink.new
    text_link.query(options)
  end
end
