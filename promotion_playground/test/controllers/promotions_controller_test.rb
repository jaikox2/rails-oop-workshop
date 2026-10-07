require "test_helper"

class PromotionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @promotion = promotions(:unused)
  end

  test "should get index" do
    get promotions_url
    assert_response :success
  end

  test "should get new" do
    get new_promotion_url
    assert_response :success
  end

  test "should create promotion" do
    assert_difference("Promotion.count") do
      post promotions_url, params: {
        promotion: {
          active: true,
          amount_cents: 5_000,
          name: "New Fixed Discount",
          type: "FixedAmountPromotion"
        }
      }
    end

    assert_redirected_to promotion_url(Promotion.order(:id).last)
  end

  test "should show promotion" do
    get promotion_url(@promotion)
    assert_response :success
  end

  test "should get edit" do
    get edit_promotion_url(@promotion)
    assert_response :success
  end

  test "should update promotion" do
    patch promotion_url(@promotion), params: {
      promotion: {
        active: true,
        amount_cents: 20_000,
        minimum_spend_cents: 120_000,
        name: "Updated Minimum Spend",
        type: @promotion.type
      }
    }

    assert_redirected_to promotion_url(@promotion)
    assert_equal "Updated Minimum Spend", @promotion.reload.name
  end

  test "should destroy promotion" do
    assert_difference("Promotion.count", -1) do
      delete promotion_url(@promotion)
    end

    assert_redirected_to promotions_url
  end
end
