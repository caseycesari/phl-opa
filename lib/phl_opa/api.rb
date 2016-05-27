require "json"
require "open-uri"
require "net/http"

module PHLopa

  API_BASE = "http://api.phila.gov/opa/v1.1/"
  DEFAULT_QUERY_STRING = "?format=json"

  class << self

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
      raise ArgumentError("Street_b must be a string") unless street_b.is_a? String
      if (street_a.nil? || street_b.nil?); raise ArgumentError("Both parameters are required") end

      response = invoke_api('intersection/', street_a + '/' + street_b)
      data = parse_response(response)

      data
    end

    def search_nearby(lat=nil, lng=nil, radius=200)
      raise ArgumentError("Latitude must be a number") unless lat.is_a? Float
      raise ArgumentError("Longitude must be a number") unless lng.is_a? Float
      raise ArgumentError("Radius must be a number") unless radius.is_a? Fixnum
      raise ArgumentError("Radius must be a positive number") unless radius > 0
      if (lat.nil? || lng.nil?); raise ArgumentError("Both latitude and longitude are required") end

      response = invoke_api('nearby/', "#{lng}/#{lat}/#{radius}")
      data = parse_response(response)

      data
    end

    private

    def parse_response(response)
      json = JSON.parse(response.body)

      json
    end

    def invoke_api(path, parameter)
      encoded = URI::encode(parameter)
      url = URI.parse("#{API_BASE}#{path}#{encoded}#{DEFAULT_QUERY_STRING}")

      Net::HTTP.get_response(url)
    end
  end
end
