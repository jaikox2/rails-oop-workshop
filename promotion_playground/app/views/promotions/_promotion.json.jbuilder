json.extract! promotion, :id, :name, :type, :active, :amount_cents, :percentage, :minimum_spend_cents, :maximum_discount_cents, :minimum_quantity, :created_at, :updated_at
json.url promotion_url(promotion, format: :json)
