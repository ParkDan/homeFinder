class ZillowService
	DOWN_PAYMENT = 20000

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

	def self.get_updated_property_details zpid
		zillow_url = "http://www.zillow.com/webservice/GetUpdatedPropertyDetails.htm?zws-id=#{ENV["ZILLOW_KEY2"]}&zpid=#{zpid}"
		response = HTTParty.get(zillow_url)
		response["updatedPropertyDetails"]["response"] ? response["updatedPropertyDetails"]["response"]["editedFacts"] : nil
	end

	def self.get_deep_comps zpid
		zillow_url = "http://www.zillow.com/webservice/GetDeepComps.htm?zws-id=#{ENV["ZILLOW_KEY2"]}&zpid=#{zpid}&count=5"
		response = HTTParty.get(zillow_url)
	end

	def self.calculate_monthly_payments price
		return if price.to_f == 0
		down_payment = ((DOWN_PAYMENT / price.to_f) * 100).to_i
		zillow_url = "http://www.zillow.com/webservice/mortgage/CalculateMonthlyPaymentsAdvanced.htm?zws-id=#{ENV['ZILLOW_KEY2']}&price=#{price}&down=#{down_payment}"
		response = HTTParty.get(zillow_url)
	end
end
