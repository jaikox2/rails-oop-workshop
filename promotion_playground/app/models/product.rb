class Product < ApplicationRecord
  has_many :order_items, dependent: :restrict_with_error

  validates :name, presence: true
  validates :sku, presence: true, uniqueness: true
  validates :price_cents,
            numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  scope :available, -> { where(active: true).order(:name) }
end
