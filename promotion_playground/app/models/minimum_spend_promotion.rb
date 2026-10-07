class MinimumSpendPromotion < Promotion
  validates :minimum_spend_cents,
            numericality: { only_integer: true, greater_than: 0 }
  validates :amount_cents,
            numericality: { only_integer: true, greater_than: 0 }

  def rule_summary
    "ซื้อครบ #{format_baht(minimum_spend_cents)} บาท ลด #{format_baht(amount_cents)} บาท"
  end

  protected

  def eligible?(order)
    super && order.subtotal_cents >= minimum_spend_cents
  end

  private

  def calculate_discount(_order)
    amount_cents
  end
end
