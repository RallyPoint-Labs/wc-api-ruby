# frozen_string_literal: true

require 'spec_helper'
require 'woocommerce_api'


describe WooCommerce::API do
  let(:basic_auth) {
    WooCommerce::API.new(
      'https://dev.test/',
      'user',
      'pass'
    )
  }

  let(:oauth) {
    WooCommerce::API.new(
      'http://dev.test/',
      'user',
      'pass'
    )
  }

  describe 'Test Basic Auth Get' do
    before do
      WebMock.stub_request(:get, 'https://dev.test/wp-json/wc/v3/customers').with(
        headers: {
          'Accept'=>'application/json',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization'=>'Basic dXNlcjpwYXNz',
          'User-Agent'=>'WooCommerce API Client-Ruby/1.4.0'
        }
      ).to_return(status: 200, body: '{"customers":[]}', headers: {})
      puts basic_auth.get('customers')
    end
    it { expect(basic_auth.get('customers').status).to eq(200)}
  end

  describe 'Test Oauth Get' do
    before do

    end
    it {}
  end

  describe 'Test Oauth Get Puts Data In Alpha Order' do
    before do

    end
    it {}
  end

  describe 'Test Basic Auth Post' do
    before do

    end
    it {}
  end

  describe 'Test Oauth Post' do
    before do

    end
    it {}
  end

  describe 'Test Basic Auth Put' do
    before do

    end
    it {}
  end

  describe 'Test Oauth Put' do
    before do

    end
    it {}
  end

  describe 'Test Basic Auth Delete' do
    before do

    end
    it {}
  end

  describe 'Test Basic Auth Delete Params' do
    before do

    end
    it {}
  end

  describe 'Test Oauth Put' do
    before do

    end
    it {}
  end

  describe 'Test Adding Query Params' do
    before do

    end
    it {}
  end

  describe 'Test Invalid Signature Method' do
    before do

    end
    it {}
  end
end