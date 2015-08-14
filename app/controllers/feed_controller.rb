require 'uri'

class FeedController < ApplicationController
  def index
  end

	def housing_details
		address1 = URI.encode(params[:address1])
		city_state_zip = URI.encode(params[:address2])
    zillow_url = "http://www.zillow.com/webservice/GetSearchResults.htm?zws-id=#{ENV["ZILLOW_KEY"]}&address=#{address1}&citystatezip=#{city_state_zip}"
		response = HTTParty.get(zillow_url)
		render json: response.to_json
	end

end
