require 'uri'

class FeedController < ApplicationController
  def index
  end

	def housing_details
		formatted_addresses = AddressParser.parse_and_encode(params[:address1], params[:address2])
		render_404("Inputs do not match, please verify data or try a smaller set.") and return unless formatted_addresses

		@responses = formatted_addresses.map do |a|
			result = ZillowService.get_deep_search_results a.first, a.last
			result ? result["searchresults"]["response"]["results"]["result"] : result
		end.compact

		render_404("No Results Found") and return if @responses.count == 0
	end

end
