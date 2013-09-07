json.array!(@orders) do |order|
  json.extract! order, :address, :payment_method, :status
  json.url order_url(order, format: :json)
end
