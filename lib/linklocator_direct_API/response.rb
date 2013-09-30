require "recursive_open_struct"

module LinklocatorDirectAPI
  class Response
    attr_reader :data, :request

    def initialize(response)
      @request = response.request
      result = response["getTextLinksResponse"]

#@total_matches = result["TotalMatches"].to_i
#@total_pages = result["TotalPages"].to_i
#@page_number = result["PageNumber"].to_i
      @data = parse(result["return"])
    end

    def all
      while page_number < total_pages
        uri = Addressable::URI.parse(request.uri)
        params = uri.query_values
        params["pagenumber"] = page_number + 1
        next_page_response = LinklocatorDirectAPI::ProductSearch.new.query(params)
        @page_number = next_page_response.page_number
        @data += next_page_response.data
      end
      @data
    end

    private

    def parse(raw_data)
      data = []
      data = [RecursiveOpenStruct.new(raw_data)] if raw_data.is_a?(Hash) # If we got exactly one result, put it in an array.
      raw_data.each { |i| data << RecursiveOpenStruct.new(i) } if raw_data.is_a?(Array)
      data
    end
  end
end
