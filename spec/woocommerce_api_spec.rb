# frozen_string_literal: true

require 'spec_helper'
require 'woocommerce_api'


describe WooCommerce::API do
  let(:woo_commerce_config) {
    WooCommerce::API.new(
      'https://dev.test/',
      'user',
      'pass'
    )
  }

  let(:basic_auth_mock) { 'Basic dXNlcjpwYXNz' }

  describe 'Test Products Get' do
    before do
      WebMock.stub_request(:get, 'https://dev.test/wp-json/wc/v3/products').with(
        headers: {
          'Accept'=>'application/json',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization'=> basic_auth_mock,
          'User-Agent'=>'WooCommerce API Client-Ruby/1.4.0'
        }
      ).to_return(status: 200, body: '{"products":[]}', headers: {})
    end
    it { expect(woo_commerce_config.get('products').status).to eq(200)}
  end

  describe 'Test Products Create' do
    let(:data) {
      product: {
        title: 'Testing product'
      }
    }
    before do
      WebMock.stub_request(:post, 'https://dev.test/wp-json/wc/v3/products').with(
        headers: {
          'Accept'=>'application/json',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization'=> basic_auth_mock,
          'User-Agent'=>'WooCommerce API Client-Ruby/1.4.0'
        }
      ).to_return(status: 200, body: '{"products":[]}', headers: {})

    end
    it { expect(woo_commerce_config.post('products', data).status).to eq(200)}
  end

  # describe 'Test Products Update' do
  #   before do
  #     WebMock.stub_request(:put, 'https://dev.test/wp-json/wc/v3/products').with(
  #       headers: {
  #         'Accept'=>'application/json',
  #         'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
  #         'Authorization'=> basic_auth_mock,
  #         'User-Agent'=>'WooCommerce API Client-Ruby/1.4.0'
  #       }
  #     ).to_return(status: 200, body: '{"products":[]}', headers: {})
  #   end
  #   it { expect(woo_commerce_config.get('products').status).to eq(200)}
  # end

  # describe 'Test Products Delete' do
  #   before do
  #     WebMock.stub_request(:delete, 'https://dev.test/wp-json/wc/v3/products').with(
  #       headers: {
  #         'Accept'=>'application/json',
  #         'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
  #         'Authorization'=> basic_auth_mock,
  #         'User-Agent'=>'WooCommerce API Client-Ruby/1.4.0'
  #       }
  #     ).to_return(status: 200, body: '{"products":[]}', headers: {})
  #   end
  #   it { expect(woo_commerce_config.get('products').status).to eq(200)}
  # end
end