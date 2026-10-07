require "application_system_test_case"

class PromotionsTest < ApplicationSystemTestCase
  setup do
    @promotion = promotions(:unused)
  end

  test "visiting the promotion list" do
    visit promotions_url
    assert_selector "h1", text: "โปรโมชั่น"
    assert_text @promotion.name
  end

  test "should create promotion" do
    visit promotions_url
    click_on "เพิ่มโปรโมชั่น"

    fill_in "ชื่อโปรโมชั่น", with: "System Fixed Discount"
    select "ลดจำนวนคงที่", from: "ประเภทโปรโมชั่น"
    fill_in "มูลค่าส่วนลด (สตางค์)", with: 5_000
    click_on "สร้างโปรโมชั่น"

    assert_text "Promotion was successfully created."
    assert_text "System Fixed Discount"
  end

  test "should update promotion" do
    visit promotion_url(@promotion)
    click_on "แก้ไขโปรโมชั่น"

    fill_in "ชื่อโปรโมชั่น", with: "Updated Minimum Spend"
    fill_in "มูลค่าส่วนลด (สตางค์)", with: 20_000
    fill_in "ยอดซื้อขั้นต่ำ (สตางค์)", with: 120_000
    click_on "บันทึกการแก้ไข"

    assert_text "Promotion was successfully updated."
    assert_text "Updated Minimum Spend"
  end

  test "should destroy promotion" do
    visit promotion_url(@promotion)

    accept_confirm do
      click_on "ลบโปรโมชั่น"
    end

    assert_text "Promotion was successfully destroyed."
  end
end
