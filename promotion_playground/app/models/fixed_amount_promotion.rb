class FixedAmountPromotion < Promotion
  validates :amount_cents,
            numericality: { only_integer: true, greater_than: 0 }

  def rule_summary
    "ลดคงที่ #{format_baht(amount_cents)} บาท"
  end

  private

  def calculate_discount(_order)
    amount_cents
  end
end
