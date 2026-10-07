require "application_system_test_case"

class ProductsTest < ApplicationSystemTestCase
  setup do
    @product = products(:unused)
  end

  test "visiting the product catalog" do
    visit products_url
    assert_selector "h1", text: "สินค้า"
    assert_text @product.name
  end

  test "should create product" do
    visit products_url
    click_on "เพิ่มสินค้า"

    fill_in "ชื่อสินค้า", with: "System Test Product"
    fill_in "SKU / รหัสสินค้า", with: "SYSTEM-TEST-SKU"
    fill_in "ราคา (สตางค์)", with: 12_900
    click_on "สร้างสินค้า"

    assert_text "Product was successfully created."
    assert_text "System Test Product"
  end

  test "should update product" do
    visit product_url(@product)
    click_on "แก้ไขสินค้า"

    fill_in "ชื่อสินค้า", with: "Updated System Product"
    fill_in "ราคา (สตางค์)", with: 15_000
    click_on "บันทึกการแก้ไข"

    assert_text "Product was successfully updated."
    assert_text "Updated System Product"
  end

  test "should destroy product" do
    visit product_url(@product)

    accept_confirm do
      click_on "ลบสินค้า"
    end

    assert_text "Product was successfully destroyed."
  end
end
