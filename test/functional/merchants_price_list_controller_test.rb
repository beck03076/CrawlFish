require 'test_helper'

class MerchantsPriceListControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
