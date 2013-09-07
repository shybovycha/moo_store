json.array!(@products) do |product|
  json.extract! product, :title, :description, :base_price
  json.url product_url(product, format: :json)
end
