class PercentagePromotion < Promotion
  validates :percentage,
            numericality: {
              only_integer: true,
              greater_than: 0,
              less_than_or_equal_to: 100
            }
  validates :maximum_discount_cents,
            numericality: { only_integer: true, greater_than: 0 },
            allow_nil: true

  def rule_summary
    cap = maximum_discount_cents.to_i.positive? ?
      " สูงสุด #{format_baht(maximum_discount_cents)} บาท" : ""

    "ลด #{percentage}%#{cap}"
  end

  private

  def calculate_discount(order)
    discount = order.subtotal_cents * percentage / 100
    return discount unless maximum_discount_cents.to_i.positive?

    [discount, maximum_discount_cents].min
  end
end
