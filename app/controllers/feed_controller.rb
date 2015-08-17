require 'uri'

class FeedController < ApplicationController
  def index
  end

	def housing_details
		formatted_addresses = AddressParser.parse_and_encode(params[:addresses])
		render_404("Inputs do not match, please verify data or try a smaller set.") and return unless formatted_addresses
		@responses = formatted_addresses.map do |address|
			result = ZillowService.get_deep_search_results address[:address1], address[:zip]
			result ? result["searchresults"]["response"]["results"]["result"] : result
		end.compact

		render_404("No Results Found") and return if @responses.count == 0
	end

end
