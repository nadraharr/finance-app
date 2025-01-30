require "test_helper"

class ReportsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get reports_index_url
    assert_response :success
  end

  test "should get report_by_category" do
    get reports_report_by_category_url
    assert_response :success
  end

  test "should get report_by_dates" do
    get reports_report_by_dates_url
    assert_response :success
  end
end
