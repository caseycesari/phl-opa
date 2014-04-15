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

    def get_by_address(address=nil)
      response = invoke_api('address/', address + '/')
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
