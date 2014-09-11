json.array!(@locations) do |location|
  json.extract! location, :id, :full_street_address, :latitude, :longitude
  json.url location_url(location, format: :json)
end
