class ZillowService
	def self.get_search_results address1, zip
			zillow_url = "http://www.zillow.com/webservice/GetSearchResults.htm?zws-id=#{ENV["ZILLOW_KEY"]}&address=#{address1}&citystatezip=#{zip}"
			response = HTTParty.get(zillow_url)
			# Silently reject failed_responses
			response["searchresults"]["response"] ? response : nil
	end

	def self.get_deep_search_results address1, zip
		zillow_url = "http://www.zillow.com/webservice/GetDeepSearchResults.htm?zws-id=#{ENV["ZILLOW_KEY"]}&address=#{address1}&citystatezip=#{zip}"
		response = HTTParty.get(zillow_url)
		# Silently reject failed_responses
		response["searchresults"]["response"] ? response : nil
	end
end
