[![Build Status](https://secure.travis-ci.org/caseypt/phl-opa.png?branch=master)](https://travis-ci.org/caseypt/phl-opa)

# PHL-opa

A thin wrapper for the Philadelphia [Office of Property Assessment API](http://phlapi.com/opaapi.html)

## Installation

Add this line to your application's Gemfile:

    gem 'phl_opa'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install phl_opa

## Usage

**#get_by_account**

Returns the property details for the provided OPA account number. This method returns the most amount of data about a given property. If you have an address, but not an OPA account number. Use the `#search_by_address` method to find the OPA account number, then this method to get all the details about the property.

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

**#search_by_address**

Searches for properties that match the provided address. In the response, the `data.properties` key is always an array, even if there is only one result

    require 'phl_opa'
    phl_opa = PHLopa::API.new
    phl_opa.search_by_address('1234 Market St')

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

**#search_by_block**

Searches for properties that are located on the provided block. In the response, the `data.properties` key is always an array, even if there is only one result.

    require 'phl_opa'
    phl_opa = PHLopa::API.new
    phl_opa.search_by_block('1234 Market St')

Response

    {
      status: "success",
      total: 3,
      data: {
        properties: [{
          property_id: "5356001200",
          account_number: "883705320",
          full_address: "1200 MARKET ST",
          unit: "",
          zip: "191073615",
          address_match: {
            original: "1200-1298 market st",
            standardized: "1200 MARKET ST",
            similarity: 100,
            match_code: "",
            match_type: "MA"
          },
          geometry: {
    ...

**#search_by_intersection**

Searches for properties that are near the provided the intersection. In the response, the `data.properties` key is always an array, even if there is only one result.

    require 'phl_opa'
    phl_opa = PHLopa::API.new
    phl_opa.search_by_intersection('Market St', '12th')

Response

    {
      status: "success",
      total: 5,
      data: {
        properties: [{
          property_id: "53560011130000001",
          account_number: "883705100",
          full_address: "1113 MARKET ST",
          unit: "0000001",
          zip: "19107-2901",
          address_match: {
            original: null,
            standardized: null,
            similarity: null,
            match_code: null,
            match_type: null
          },
          geometry: {
    ...

**#search_nearby**

Searches for properties that are near the provide latitude/longitude coordinate, and within the provided radius. The default distance for `radius` is 200 feet, and is not required. In the response, the `data.properties` key is always an array, even if there is only one result.

    require 'phl_opa'
    phl_opa = PHLopa::API.new
    phl_opa.search_nearby(-75.16097, 39.95166, 400)

Response

    {
      status: "success",
      total: 25,
      data: {
        properties: [{
        property_id: "5356001200",
        account_number: "883705320",
        full_address: "1200 MARKET ST",
        unit: "",
        zip: "191073615",
        address_match: {
          original: null,
          standardized: null,
          similarity: null,
          match_code: null,
          match_type: null
        },
        geometry: {
    ...

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
