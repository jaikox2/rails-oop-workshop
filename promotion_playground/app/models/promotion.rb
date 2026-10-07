class Promotion < ApplicationRecord
  TYPES = %w[
    FixedAmountPromotion
    PercentagePromotion
    MinimumSpendPromotion
  ].freeze

  TYPE_LABELS = {
    "FixedAmountPromotion" => "ลดจำนวนคงที่",
    "PercentagePromotion" => "ลดเป็นเปอร์เซ็นต์",
    "MinimumSpendPromotion" => "ลดเมื่อซื้อถึงขั้นต่ำ"
  }.freeze

  # ทำให้ form_with และ redirect_to ใช้ /promotions กับ STI subclasses
  def self.model_name
    return super if self == Promotion

    Promotion.model_name
  end

  has_many :orders, dependent: :restrict_with_error

  validates :name, presence: true
  validates :type, inclusion: { in: TYPES }

  scope :active, -> { where(active: true).order(:name) }

  # Template Method: ลำดับหลักเหมือนกันทุก Promotion
  def discount_for(order)
    return 0 unless eligible?(order)

    calculate_discount(order).to_i.clamp(0, order.subtotal_cents.to_i)
  end

  def type_label
    TYPE_LABELS.fetch(type, type)
  end

  def rule_summary
    raise NotImplementedError, "#{self.class} must implement #rule_summary"
  end

  protected

  def eligible?(_order)
    active?
  end

  def format_baht(cents)
    format("%.2f", cents.to_i / 100.0)
  end

  private

  def calculate_discount(_order)
    raise NotImplementedError, "#{self.class} must implement #calculate_discount"
  end
end
