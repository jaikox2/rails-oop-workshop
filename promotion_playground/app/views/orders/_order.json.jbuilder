json.extract! order, :id, :customer_name, :status, :promotion_id, :subtotal_cents, :discount_cents, :total_cents, :created_at, :updated_at
json.url order_url(order, format: :json)
