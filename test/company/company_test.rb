# frozen_string_literal: true

require "test_helper"

class SellsyV2CompanyTest < Minitest::Test
  def test_exists
    assert SellsyV2::Company
  end

  def test_it_gives_back_a_single_company
    VCR.use_cassette("one_company") do
      company = SellsyV2::Company.find(83426)
      assert_equal SellsyV2::Company, company.class

      # Check that the fields are accessible by our model

      assert_equal 83426, company.id
      assert_equal "Curius", company.name
      assert_equal "client", company.type
    end

    VCR.use_cassette("another_company") do
      company = SellsyV2::Company.find(174541)
    end
  end

  def test_all_returns_an_array_of_companies
    VCR.use_cassette("all_companies") do
      companies = SellsyV2::Company.all
      assert_equal Array, companies.class
      assert_equal SellsyV2::Company, companies.first.class
    end
  end
end
