# frozen_string_literal: true
require 'json'

module SellsyV2
  class Company
    ROOT_PATH = '/companies'

    def initialize(attr)
      attr.each do |k,v|
        define_singleton_method(k) { instance_variable_get("@#{k}") }
        define_singleton_method("#{k}=") { |val| instance_variable_set("@#{k}", val) }

        instance_variable_set("@#{k}", v)
      end
    end

    def self.all(**options)
      companies_response = Request.new(path: ROOT_PATH, verb: 'get', options: options).call
      if companies_response.success?
        companies_response.data.dig('data').map{Company.new(_1)}
      end
    end

    def self.find(id, **options)
      company_response = Request.new(path: "#{ROOT_PATH}/#{id}", verb: 'get', options: options).call
      if company_response.success?
        Company.new(company_response.data)
      end
    end

    def addresses(**options)
      verb = 'get'
      path = "#{ROOT_PATH}/#{id}/addresses"
      company_addresses_response = Request.new(path: path, verb: verb, options: options).call
      if company_addresses_response.success?
        company_addresses_response.data.dig('data').map{Address.new(_1)}
      end
    end
  end
end
