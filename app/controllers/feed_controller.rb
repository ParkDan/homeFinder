require 'uri'
require 'json'

class FeedController < ApplicationController
  def index; end

  def format_addresses
		formatted_addresses = AddressParser.parse_and_encode(params[:addresses])
		render json: formatted_addresses.to_json
  end

	def	build_addresses
		formatted_addresses = params[:formatted_addresses]
		render_404("Inputs do not match, please verify data or try a smaller set.") and return unless formatted_addresses
		@data_set = RealEstateData.new(formatted_addresses).data
		# @data_set = JSON.parse(File.read('public/mock_response.json'))
		render_404("No Results Found") and return unless @data_set

		render json: @data_set.to_json
	end
end
