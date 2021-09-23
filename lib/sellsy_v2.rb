# frozen_string_literal: true

require_relative "sellsy_v2/version"
require_relative "sellsy_v2/company"
require_relative "sellsy_v2/company/address"

module SellsyV2
  class Error < StandardError; end
  # Your code goes here...
  class Request
    require "uri"
    require "net/http"
    require "json"

    def initialize(verb:, path:, options:)
      params = '?' + options.map{|k,v| v.class == Array ? "#{k}[]=#{v.join(',')}" : "#{k}=#{v}"}.join('&')
      @url = URI("https://api.sellsy.com/v2#{path}#{params}")
    end

    def call
      https = Net::HTTP.new(@url.host, @url.port)
      https.use_ssl = true

      request = Net::HTTP::Get.new(@url) # change to verb
      request["Authorization"] = ENV["SELLSY_TOKEN"]

      response = https.request(request)

      if response.is_a?(Net::HTTPOK)
        OpenStruct.new(success?: true, data: JSON.parse(response.read_body))
      else
        OpenStruct.new(success?: false, data: response)
      end
    end
  end
end
