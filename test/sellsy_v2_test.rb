# frozen_string_literal: true

require "test_helper"

class SellsyV2Test < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::SellsyV2::VERSION
  end

  def test_it_does_something_useful
    assert true
  end

  def test_search_returns_results
    VCR.use_cassette("search_sellsy") do
      search_results = SellsyV2::Search.new(query: "box", type: ['company'])
      refute_nil search_results
    end
  end
end
