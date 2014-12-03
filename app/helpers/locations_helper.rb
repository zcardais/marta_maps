module LocationsHelper


	def address_combiner(street, state, city)
		street + ", " + city +  ", " + state
	end

	def lat_long_finder(street, state, city)
		address = address_combiner(street, state, city)

		#coordinates is returned as an array,
		#.first -> lat, .last -> long
		@coordinates = Geocoder.coordinates(address)
	end
end
