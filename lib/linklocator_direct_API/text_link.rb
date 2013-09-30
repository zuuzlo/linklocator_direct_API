require "addressable/uri"
require "httparty"

module LinklocatorDirectAPI
  # For implimentation details visit
  # http://helpcenter.linkshare.com/publisher/questions.php?questionid=58
  class TextLink
    include HTTParty
    
    attr_reader :api_base_url, :api_timeout, :token

    def initialize
      @token = LinklocatorDirectAPI.token
      @api_base_url = LinklocatorDirectAPI::WEB_SERVICE_URIS[:text_link]
      @api_timeout = LinklocatorDirectAPI.api_timeout

      if @token.nil?
        raise AuthenticationError.new(
          "No token. Set your token by using 'LinklocatorDirectAPI.token = <TOKEN>'. " +
          "You can retrieve your token from LinkhShare's Web Services page under the Links tab. " +
          "See http://helpcenter.linkshare.com/publisher/questions.php?questionid=648 for details."
        )
      end
    end

    def query(params)

      raise ArgumentError, "Hash expected, got #{params.class} instead" unless params.is_a?(Hash)

      check_date_format(params[:startDate])
      check_date_format(params[:endDate])
      make_params_valid(params)

      begin
        response = self.class.get(
          api_base_url + "/#{token}/#{params[:mid]}/#{params[:cat]}/#{params[:startDate]}/#{params[:endData]}/-1/#{params[:page]}",
          query: nil,
          timeout: api_timeout
        )
      rescue Timeout::Error
        raise ConnectionError.new("Timeout error (#{timeout}s)")
      end

      if response.code != 200
        raise Error.new(response.message, response.code)
      end
      error = response["ns1:XMLFault"]
      raise InvalidRequestError.new(error["ns1:faultstring"]) if error
      Response.new(response)
    end

    private

    def check_date_format(date)
      if date
        raise ArgumentError, "Data format needs to be MMDDYYY." unless date =~ /(0[1-9]|1[012])(0[1-9]|[12][0-9]|3[01])(19|20)\d\d/
      end
    end

    def make_params_valid(params)
      unless params[:mid]
        params[:mid] = -1
      end

      unless params[:cat]
        params[:cat] = -1
      end

      unless params[:page]
        params[:page] = 1
      end
    end
  end
end
