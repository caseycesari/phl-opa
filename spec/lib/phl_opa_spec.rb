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
      @phl_opa.get_by_account(883309000)['data']['property']['full_address'] = '1234 MARKET ST'
    end
  end
end
