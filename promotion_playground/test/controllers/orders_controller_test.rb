require "test_helper"

class OrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @order = orders(:one)
  end

  test "should get index" do
    get orders_url
    assert_response :success
  end

  test "should get new" do
    get new_order_url
    assert_response :success
  end

  test "should create order from nested line items" do
    assert_difference("Order.count") do
      post orders_url, params: {
        order: {
          customer_name: "New Customer",
          promotion_id: promotions(:two).id,
          status: "draft",
          order_items_attributes: {
            "0" => {
              product_id: products(:one).id,
              quantity: 2
            }
          }
        }
      }
    end

    created_order = Order.order(:id).last
    assert_redirected_to order_url(created_order)
    assert_equal 118_000, created_order.subtotal_cents
    assert_equal 11_800, created_order.discount_cents
    assert_equal 106_200, created_order.total_cents
  end

  test "should show order" do
    get order_url(@order)
    assert_response :success
  end

  test "should get edit" do
    get edit_order_url(@order)
    assert_response :success
  end

  test "should update order and recalculate totals" do
    item = @order.order_items.first

    patch order_url(@order), params: {
      order: {
        customer_name: "Updated Customer",
        promotion_id: promotions(:one).id,
        status: "confirmed",
        order_items_attributes: {
          "0" => {
            id: item.id,
            product_id: item.product_id,
            quantity: 3
          }
        }
      }
    }

    assert_redirected_to order_url(@order)
    @order.reload
    assert_equal "Updated Customer", @order.customer_name
    assert_equal 177_000, @order.subtotal_cents
    assert_equal 10_000, @order.discount_cents
    assert_equal 167_000, @order.total_cents
  end

  test "should destroy order" do
    assert_difference("Order.count", -1) do
      delete order_url(@order)
    end

    assert_redirected_to orders_url
  end
end
