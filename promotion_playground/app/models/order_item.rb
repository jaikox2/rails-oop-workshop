class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :quantity,
            numericality: { only_integer: true, greater_than: 0 }
  validates :unit_price_cents,
            numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  # Snapshot ราคา: ราคา Product เปลี่ยนภายหลังจะไม่กระทบ Order เดิม
  def capture_unit_price
    return if product.blank?
    return unless unit_price_cents.blank? || will_save_change_to_product_id?

    self.unit_price_cents = product.price_cents
  end

  def subtotal_cents
    unit_price_cents.to_i * quantity.to_i
  end
end
