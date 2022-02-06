# frozen_string_literal: true

require 'minitest/autorun'
require 'webmock/minitest'
require 'json'
require 'woocommerce_api'

class WooCommerceAPITest < Minitest::Test
  def setup
    basic_auth = WooCommerce::API.new(
      'https://dev.test/',
      'user',
      'pass'
    )

    oauth = WooCommerce::API.new(
      'http://dev.test/',
      'user',
      'pass'
    )
  end

  def test_oauth_get
    WebMock.stub_request(:get, %r{http://dev\.test/wc-api/v3/customers\?oauth_consumer_key=user&oauth_nonce=(.*)&(.*)oauth_signature_method=HMAC-SHA256&oauth_timestamp=(.*)}).with(
      headers: {
        content_type: 'application/json'
      }
    ).to_return(body: '{"customers":[]}')
    response = oauth.get 'customers'

    assert_equal 200, response.code
  end

  def test_oauth_get_puts_data_in_alpha_order
    WebMock.stub_request(:get, %r{http://dev\.test/wc-api/v3/customers\?abc=123&oauth_consumer_key=user&oauth_d=456&oauth_nonce=(.*)&(.*)oauth_signature_method=HMAC-SHA256&oauth_timestamp=(.*)&xyz=789}).with(
      headers: {
        content_type: 'application/json'
      }
    ).to_return(body: '{"customers":[]}')
    response = oauth.get 'customers', abc: '123', oauth_d: '456', xyz: '789'

    assert_equal 200, response.code
  end

  def test_basic_auth_post
    WebMock.stub_request(:post, 'https://user:pass@dev.test/wc-api/v3/products').with(
      headers: {
        content_type: 'application/json'
      },
    ).to_return(status: 201, '{"products":[]}')

    data = {
      product: {
        title: 'Testing product'
      }
    }
    response = basic_auth.post 'products', data

    assert_equal 201, response.code
  end

  def test_oauth_post
    WebMock.stub_request(:post, %r{http://dev\.test/wc-api/v3/products\?oauth_consumer_key=user&oauth_nonce=(.*)&(.*)oauth_signature_method=HMAC-SHA256&oauth_timestamp=(.*)}).with(
      headers: {
        content_type: 'application/json'
      },
    ).to_return(status: 201, '{"products":[]}')

    data = {
      product: {
        title: 'Testing product'
      }
    }
    response = oauth.post 'products', data

    assert_equal 201, response.code
  end

  def test_basic_auth_put
    WebMock.stub_request(:put, 'https://user:pass@dev.test/wc-api/v3/products/1234').with(
      headers: {
        content_type: 'application/json'
      }
    ).to_return(body: '{"customers":[]}')

    data = {
      product: {
        title: 'Updating product title'
      }
    }
    response = basic_auth.put 'products/1234', data

    assert_equal 200, response.code
  end

  def test_oauth_put
    WebMock.stub_request(:put, %r{http://dev\.test/wc-api/v3/products\?oauth_consumer_key=user&oauth_nonce=(.*)&(.*)oauth_signature_method=HMAC-SHA256&oauth_timestamp=(.*)}).with(
      headers: {
        content_type: 'application/json'
      }
    ).to_return(body: '{"products":[]}')

    data = {
      product: {
        title: 'Updating product title'
      }
    }
    response = oauth.put 'products', data

    assert_equal 200, response.code
  end

  def test_basic_auth_delete
    WebMock.stub_request(:delete, 'https://user:pass@dev.test/wc-api/v3/products/1234?force=true').with(
      headers: {
        content_type: 'application/json'
      },
    ).to_return(status: 202, '{"message":"Permanently deleted product"}')

    response = basic_auth.delete 'products/1234?force=true'

    assert_equal 202, response.code
    assert_equal '{"message":"Permanently deleted product"}', response.to_json
  end

  def test_basic_auth_delete_params
    WebMock.stub_request(:delete, 'https://user:pass@dev.test/wc-api/v3/products/1234?force=true').with(
      headers: {
        content_type: 'application/json'
      },
    ).to_return(status: 202, '{"message":"Permanently deleted product"}')

    response = basic_auth.delete 'products/1234', force: true

    assert_equal 202, response.code
    assert_equal '{"message":"Permanently deleted product"}', response.to_json
  end

  def test_oauth_put
    WebMock.stub_request(:delete, %r{http://dev\.test/wc-api/v3/products/1234\?force=true&oauth_consumer_key=user&oauth_nonce=(.*)&(.*)oauth_signature_method=HMAC-SHA256&oauth_timestamp=(.*)}).with(
      headers: {
        content_type: 'application/json'
      },
    ).to_return(status: 202, '{"message":"Permanently deleted product"}')

    response = oauth.delete 'products/1234?force=true'

    assert_equal 202, response.code
    assert_equal '{"message":"Permanently deleted product"}', response.to_json
  end

  def test_adding_query_params
    url = oauth.send(:add_query_params, 'foo.com', filter: { sku: '123' }, order: 'created_at')
    assert_equal url, CGI.escape('foo.com?filter[sku]=123&order=created_at')
  end

end
