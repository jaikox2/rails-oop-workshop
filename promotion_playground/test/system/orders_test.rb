require "application_system_test_case"

class OrdersTest < ApplicationSystemTestCase
  setup do
    @order = orders(:one)
  end

  test "visiting the order workspace" do
    visit orders_url
    assert_selector "h1", text: "ออเดอร์"
    assert_text @order.customer_name
  end

  test "should create order from a nested line item" do
    visit orders_url
    click_on "สร้างออเดอร์"

    fill_in "ชื่อลูกค้า", with: "System Test Customer"
    select "ฉบับร่าง", from: "สถานะ"

    within all(".line-item-card").first do
      select "Live T-Shirt — ฿590.00", from: "สินค้า"
      fill_in "จำนวน", with: 2
    end

    click_on "สร้างออเดอร์"

    assert_text "สร้างออเดอร์เรียบร้อยแล้ว"
    assert_text "System Test Customer"
    assert_text "฿1,180.00"
  end

  test "should update order and recalculate" do
    visit order_url(@order)
    click_on "แก้ไขออเดอร์"

    fill_in "ชื่อลูกค้า", with: "Updated System Customer"
    select "ยืนยันแล้ว", from: "สถานะ"

    within all(".line-item-card").first do
      fill_in "จำนวน", with: 3
    end

    click_on "บันทึกการแก้ไข"

    assert_text "อัปเดตออเดอร์เรียบร้อยแล้ว"
    assert_text "Updated System Customer"
    assert_text "฿1,670.00"
  end

  test "should destroy order" do
    visit order_url(@order)

    accept_confirm do
      click_on "ลบออเดอร์"
    end

    assert_text "ลบออเดอร์เรียบร้อยแล้ว"
  end
end
