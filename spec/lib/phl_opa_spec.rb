require 'spec_helper'

describe PHLOpa do

  describe "#new" do
    before :each do
      @phl_opa = PHLOpa::API.new
    end
  end

  describe "#get_by_account" do
    before :each do
      @phl_opa = PHLOpa::API.new
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
end
