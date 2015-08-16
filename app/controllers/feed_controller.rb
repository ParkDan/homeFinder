require 'uri'

class FeedController < ApplicationController
  def index
  end

	def housing_details


		addresses = params[:address1].split("|").each{|s| s.slice!("\t") }.map {|a| URI.encode(a)}
		zips = params[:address2].split("|").each{|s| s.slice!("\t") }.map {|a| URI.encode(a)}

		render_404("Inputs do not match, you pasted in #{addresses.count} streets, and #{zips.count} zipcodes.") and return if addresses.count != zips.count

		formatted_addresses = addresses.zip zips
		responses = []
		failed_responses = []
		formatted_addresses.each do |address|
    	zillow_url = "http://www.zillow.com/webservice/GetSearchResults.htm?zws-id=#{ENV["ZILLOW_KEY"]}&address=#{address.first}&citystatezip=#{address.last}"
			response = HTTParty.get(zillow_url)
			response["searchresults"]["response"] ? responses << response : failed_responses << response
		end

		render_404("No Results Found") and return if responses.count == 0

		render json: responses.to_json
	end

end
