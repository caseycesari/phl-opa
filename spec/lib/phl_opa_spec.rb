require 'spec_helper'

describe PHLopa do

  describe "#new" do
    before :each do
      @phl_opa = PHLopa::API.new
    end
  end

  describe "#get_by_account" do
    before :each do
      @phl_opa = PHLopa::API.new
    end

    it "returns the property details for the OPA account that is passed" do
      @phl_opa.get_by_account('883309000')['data']['property']['full_address'] = '1234 MARKET ST'
    end

    it "raises an error if the account argument is not a string" do
      lambda { @phl_opa.get_by_account(123456780) }.should raise_error
      lambda { @phl_opa.get_by_account([123456780]) }.should raise_error
    end

    it "raises an error if the length of the account argument is not exactly 9" do
      lambda { @phl_opa.get_by_account('12345678') }.should raise_error
      lambda { @phl_opa.get_by_account('12345678910') }.should raise_error
    end

    it "raises an error if the account argument contains anything but numbers" do
      lambda { @phl_opa.get_by_account('123456780z') }.should raise_error
      lambda { @phl_opa.get_by_account('12345ddfdf6780') }.should raise_error
    end
  end

  describe "#search_by_address" do
    before :each do
      @phl_opa = PHLopa::API.new
    end

    it "returns the property details for the adress that is passed" do
      @phl_opa.search_by_address('1234 Market St')['data']['properties'][0]['account_number'] = '883309000'
    end

    it "raises an error if the address argument is not a string" do
      lambda { @phl_opa.search_by_address(123456780) }.should raise_error
      lambda { @phl_opa.search_by_address(['1234 Market St']) }.should raise_error
    end
  end

  describe "#search_by_block" do
    before :each do
      @phl_opa = PHLopa::API.new
    end

    it "returns the property details for all the properties on the searched block" do
      @phl_opa.search_by_block('1200 Market St')['total'] = 3
    end

    it "raises an error if the address argument is not a string" do
      lambda { @phl_opa.search_by_block(123456780) }.should raise_error
      lambda { @phl_opa.search_by_block(['1234 Market St']) }.should raise_error
    end
  end

  describe "#search_by_intersection" do
    before :each do
      @phl_opa = PHLopa::API.new
    end

    it "returns the property details for all the properties near the provided intersection" do
      @phl_opa.search_by_intersection('12th', 'Market')['total'] = 5
    end

    it "raises an error if the address argument is not a string" do
      lambda { @phl_opa.search_by_intersection(12, 'Market') }.should raise_error
      lambda { @phl_opa.search_by_intersection('Market', 12) }.should raise_error
    end

    it "raises an error if either of the street arguments are nil" do
      lambda { @phl_opa.search_by_intersection('Market') }.should raise_error
      lambda { @phl_opa.search_by_intersection(nil, 'Market') }.should raise_error
    end
  end

end
