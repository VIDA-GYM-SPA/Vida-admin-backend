require "test_helper"

class DashboardControllerTest < ActionDispatch::IntegrationTest
  test "should get status_card" do
    get dashboard_status_card_url
    assert_response :success
  end

  test "should get invoices" do
    get dashboard_invoices_url
    assert_response :success
  end
end
