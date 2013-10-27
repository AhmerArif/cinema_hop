json.array!(@cities) do |city|
  json.extract! city, 
  json.url city_url(city, format: :json)
end
