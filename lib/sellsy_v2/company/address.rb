# frozen_string_literal: true
require 'json'

module SellsyV2
  class Company
    class Address

      def initialize(attr)
        attr.each do |k,v|
          define_singleton_method(k) { instance_variable_get("@#{k}") }
          define_singleton_method("#{k}=") { |val| instance_variable_set("@#{k}", val) }

          instance_variable_set("@#{k}", v)
        end
      end
    end
  end
end
