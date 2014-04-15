require "json"
require "open-uri"
require "net/http"

module PHLOpa
  class API
    attr_accessor :settings

    def initialize(options={})
      @settings = {
        :api_base => "http://api.phila.gov/opa/v1.0/",
        :default_query_string => "?format=json"
      }.merge(options)
    end

    def get_by_account(account=nil)
      response = invoke_api('account/', account)
      data = parse_response(response)

      data
    end

    def parse_response(response)
      json = JSON.parse(response.body)

      json
    end

    def invoke_api(path, parameter)
      url = URI.parse("#{@settings[:api_base]}#{path}#{parameter}#{@settings[:default_query_string]}")

      Net::HTTP.get_response(url)
    end
  end
end
