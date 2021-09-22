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

    def self.all
      Request.new(path: ROOT_PATH, verb: 'get').call.dig('data').map{Company.new(_1)}
    end

    def self.find(id)
      Company.new(Request.new(path: "#{ROOT_PATH}/#{id}", verb: 'get').call)
    end
  end
end
