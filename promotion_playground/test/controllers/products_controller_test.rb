require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = products(:unused)
  end

  test "should get index" do
    get products_url
    assert_response :success
  end

  test "should get new" do
    get new_product_url
    assert_response :success
  end

  test "should create product" do
    assert_difference("Product.count") do
      post products_url, params: {
        product: {
          active: true,
          name: "New Workshop Product",
          price_cents: 12_900,
          sku: "NEW-TEST-SKU"
        }
      }
    end

    assert_redirected_to product_url(Product.last)
  end

  test "should show product" do
    get product_url(@product)
    assert_response :success
  end

  test "should get edit" do
    get edit_product_url(@product)
    assert_response :success
  end

  test "should update product" do
    patch product_url(@product), params: {
      product: {
        active: false,
        name: "Updated Product",
        price_cents: 15_000,
        sku: @product.sku
      }
    }

    assert_redirected_to product_url(@product)
    assert_equal "Updated Product", @product.reload.name
  end

  test "should destroy product" do
    assert_difference("Product.count", -1) do
      delete product_url(@product)
    end

    assert_redirected_to products_url
  end
end
