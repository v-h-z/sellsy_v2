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
      refute_nil company
    end

    VCR.use_cassette("BOX_company") do
      company = SellsyV2::Company.find(15176997)
      refute_nil company
      assert_equal 'BOX', company.name
    end

    VCR.use_cassette("company_with_embed_estimates") do
      company = SellsyV2::Company.find(83426, embed: ['estimates'])
      refute_nil company._embed
    end
  end

  def test_all_returns_an_array_of_companies
    VCR.use_cassette("all_companies") do
      companies = SellsyV2::Company.all
      assert_equal Array, companies.class
      assert_equal SellsyV2::Company, companies.first.class
      assert companies.count <= 25
    end

    VCR.use_cassette("all_companies_with_options") do
      companies = SellsyV2::Company.all(limit: 50, offset: 5)
      assert companies.count == 50
    end
  end

  def test_addresses_method_returns_array_of_addresses
    VCR.use_cassette("one_company_addresses") do
      company = SellsyV2::Company.find(83426)
      refute_nil company.addresses
      assert_equal Array, company.addresses.class
      assert_equal SellsyV2::Company::Address, company.addresses.first.class
    end
  end
end
