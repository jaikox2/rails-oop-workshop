products = [
  { name: "Live T-Shirt", sku: "SHIRT-LIVE", price_cents: 59_000, active: true },
  { name: "Canvas Bag", sku: "BAG-CANVAS", price_cents: 35_000, active: true },
  { name: "Ceramic Mug", sku: "MUG-WHITE", price_cents: 29_000, active: true },
  { name: "Sticker Pack", sku: "STICKER-01", price_cents: 9_000, active: true }
]

products.each do |attributes|
  Product.find_or_initialize_by(sku: attributes[:sku]).update!(attributes)
end

fixed = FixedAmountPromotion.find_or_initialize_by(name: "ลดทันที 100 บาท")
fixed.update!(active: true, amount_cents: 10_000)

percentage = PercentagePromotion.find_or_initialize_by(name: "ลด 10% สูงสุด 200 บาท")
percentage.update!(active: true, percentage: 10, maximum_discount_cents: 20_000)

minimum = MinimumSpendPromotion.find_or_initialize_by(name: "ครบ 1,000 ลด 150 บาท")
minimum.update!(active: true, minimum_spend_cents: 100_000, amount_cents: 15_000)

order = Order.find_or_initialize_by(customer_name: "Alice Demo")
order.status = :draft
order.promotion = percentage

[
  [Product.find_by!(sku: "SHIRT-LIVE"), 2],
  [Product.find_by!(sku: "BAG-CANVAS"), 1]
].each do |product, quantity|
  item = order.order_items.detect { |row| row.product_id == product.id } ||
         order.order_items.build(product: product)
  item.quantity = quantity
  item.unit_price_cents = product.price_cents
end

order.recalculate_totals
order.save!

puts "Seed complete: #{Product.count} products, #{Promotion.count} promotions, #{Order.count} order"
