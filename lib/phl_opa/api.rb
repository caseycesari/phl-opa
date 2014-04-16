require "json"
require "open-uri"
require "net/http"

module PHLopa
  class API
    attr_accessor :settings

    def initialize(options={})
      @settings = {
        :api_base => "http://api.phila.gov/opa/v1.0/",
        :default_query_string => "?format=json"
      }.merge(options)
    end

    def get_by_account(account=nil)
      raise ArgumentError("Account Number must be 9 digits long") unless account.length == 9
      raise ArgumentError("Account Number must be a string") unless account.is_a? String
      raise ArgumentError("Account Number must be made up only of numbers") unless account !~ /\D/

      response = invoke_api('account/', account)
      data = parse_response(response)

      data
    end

    def search_by_address(address=nil)
      raise ArgumentError("Address must be a string") unless address.is_a? String

      response = invoke_api('address/', address + '/')
      data = parse_response(response)

      data
    end

    def search_by_block(block=nil)
      raise ArgumentError("Block must be a string") unless block.is_a? String

      response = invoke_api('block/', block + '/')
      data = parse_response(response)

      data
    end

    def search_by_intersection(street_a=nil, street_b=nil)
      raise ArgumentError("Street_a must be a string") unless street_a.is_a? String
      raise ArgumentError("Street_a must be a string") unless street_a.is_a? String
      if (street_a.nil? || street_b.nil?); raise ArgumentError("Both parameters are required") end

      response = invoke_api('intersection/', street_a + '/' + street_b)
      data = parse_response(response)

      data
    end

    def parse_response(response)
      json = JSON.parse(response.body)

      json
    end

    def invoke_api(path, parameter)
      encoded = URI::encode(parameter)
      url = URI.parse("#{@settings[:api_base]}#{path}#{encoded}#{@settings[:default_query_string]}")

      Net::HTTP.get_response(url)
    end
  end
end
