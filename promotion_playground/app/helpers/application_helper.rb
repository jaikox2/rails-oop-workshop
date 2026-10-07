module ApplicationHelper
  def money(cents)
    number_to_currency(
      cents.to_i / 100.0,
      unit: "฿",
      format: "%u%n",
      delimiter: ",",
      precision: 2
    )
  end
end
