# frozen_string_literal: true

require_relative "sellsy_v2/version"
require_relative "sellsy_v2/company"

module SellsyV2
  class Error < StandardError; end
  # Your code goes here...
  class Request
    require "uri"
    require "net/http"
    require "json"

    def initialize(verb:, path:)
      @url = URI("https://api.sellsy.com/v2#{path}")
    end

    def call
      https = Net::HTTP.new(@url.host, @url.port)
      https.use_ssl = true

      request = Net::HTTP::Get.new(@url) # change to verb
      request["Authorization"] = ENV["SELLSY_TOKEN"]

      response = https.request(request)

      if response.is_a?(Net::HTTPOK)
        JSON.parse(response.read_body)
      else
        false
      end
    end
  end
end
