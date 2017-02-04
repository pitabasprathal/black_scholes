require 'test_helper'

class MarketValuesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @market_value = market_values(:one)
  end

  test "should get index" do
    get market_values_url
    assert_response :success
  end

  test "should get new" do
    get new_market_value_url
    assert_response :success
  end

  test "should create market_value" do
    assert_difference('MarketValue.count') do
      post market_values_url, params: { market_value: { direction_id: @market_value.direction_id, interest_rate: @market_value.interest_rate, maturity_time: @market_value.maturity_time, stock_price: @market_value.stock_price, strike_price: @market_value.strike_price, volatility: @market_value.volatility } }
    end

    assert_redirected_to market_value_url(MarketValue.last)
  end

  test "should show market_value" do
    get market_value_url(@market_value)
    assert_response :success
  end

  test "should get edit" do
    get edit_market_value_url(@market_value)
    assert_response :success
  end

  test "should update market_value" do
    patch market_value_url(@market_value), params: { market_value: { direction_id: @market_value.direction_id, interest_rate: @market_value.interest_rate, maturity_time: @market_value.maturity_time, stock_price: @market_value.stock_price, strike_price: @market_value.strike_price, volatility: @market_value.volatility } }
    assert_redirected_to market_value_url(@market_value)
  end

  test "should destroy market_value" do
    assert_difference('MarketValue.count', -1) do
      delete market_value_url(@market_value)
    end

    assert_redirected_to market_values_url
  end
end
