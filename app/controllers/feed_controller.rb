require 'uri'

class FeedController < ApplicationController
  def index; end

	def housing_details
		formatted_addresses = AddressParser.parse_and_encode(params[:addresses])
		render_404("Inputs do not match, please verify data or try a smaller set.") and return unless formatted_addresses
		@data_set = RealEstateData.new(formatted_addresses).data
		render_404("No Results Found") and return unless @data_set
	end
end
