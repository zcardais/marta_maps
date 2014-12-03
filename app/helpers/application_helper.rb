module ApplicationHelper
	def fetch_url_data(source)
    http = Net::HTTP.get_response(URI.parse(source))
    data = http.body
    response = JSON.parse(data)
    return response
  end

  def nearby(lng1, lat1, lng2, lat2)
    if (lng1 - lng2).abs <= 0.01 && (lat1 - lat2).abs <= 0.01
      return true
    else
      return false
    end
  end
end
