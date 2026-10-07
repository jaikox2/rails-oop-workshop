class Order < ApplicationRecord
  belongs_to :promotion, optional: true
  has_many :order_items, inverse_of: :order, dependent: :destroy

  accepts_nested_attributes_for :order_items,
                                allow_destroy: true,
                                reject_if: ->(attributes) { attributes["product_id"].blank? }

  enum :status, { draft: 0, confirmed: 1, cancelled: 2 }, default: :draft

  validates :customer_name, presence: true
  validate :must_have_at_least_one_item

  def active_items
    order_items.reject(&:marked_for_destruction?)
  end

  def total_quantity
    active_items.sum { |item| item.quantity.to_i }
  end

  def recalculate_totals
    active_items.each(&:capture_unit_price)
    self.subtotal_cents = active_items.sum(&:subtotal_cents)
    self.discount_cents = (promotion&.discount_for(self)).to_i
    self.total_cents = subtotal_cents - discount_cents
    self
  end

  private

  def must_have_at_least_one_item
    return if active_items.any? { |item| item.product_id.present? }

    errors.add(:order_items, "ต้องมีสินค้าอย่างน้อยหนึ่งรายการ")
  end
end
