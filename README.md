[![Build Status](https://secure.travis-ci.org/caseypt/phl-opa.png?branch=master)](https://travis-ci.org/caseypt/phl-opa)

# PHL-opa

A thin wrapper for the Philadelphia Office of Property Assessment API

## Installation

Add this line to your application's Gemfile:

    gem 'phl_opa'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install phl_opa

## Usage

Search by account number

    require 'phl_opa'
    phl_opa = PHLopa::API.new
    phl_opa.get_by_account(883309000)

Response:

    {
      status: "success",
      data: {
        property: {
          property_id: "5356001234",
          account_number: "883309000",
          full_address: "1234 MARKET ST",
          unit: "",
          zip: "19107-3615",
          geometry: {
            x: -75.16097581817294,
            y: 39.95166185436387
          },
          ownership: {
            owners: [
              "SEPTA"
            ],
          }
      ...

Search by address

    require 'phl_opa'
    phl_opa = PHLopa::API.new
    phl_opa.get_by_address('1234 Market St')

Response

    {
      status: "success",
      total: 1,
      data: {
        properties: [{
          property_id: "5356001234",
          account_number: "883309000",
          full_address: "1234 MARKET ST",
          unit: "",
          zip: "19107-3615",
          address_match: {
            original: "1234 market st",
            standardized: "1234 MARKET ST",
            similarity: 100,
            match_code: "",
            match_type: "MA"
          },
          geometry: {
    ...

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
