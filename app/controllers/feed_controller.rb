require 'uri'

class FeedController < ApplicationController
  def index
  end

	def housing_details
		formatted_addresses = AddressParser.parse_and_encode(params[:addresses])
		render_404("Inputs do not match, please verify data or try a smaller set.") and return unless formatted_addresses
		@data_set = RealEstateData.new(formatted_addresses).data
		render_404("No Results Found") and return unless @data_set
	end

		# @updated_property_details = []


		# @deep_search_responses.each do |response|
		#  updated_property_result = ZillowService.get_updated_property_details response['zpid'] if response['zpid']
		#  get_deep_comps_result = ZillowService.get_deep_comps response['zpid'] if response['zpid']

		#  price = response["zestimate"]["amount"]["__content__"] if response["zestimate"] && response["zestimate"]["amount"]
		#  monthly_payments_response = ZillowService.calculate_monthly_payments price if price

		#  {"paymentsdetails"=>
  # {"request"=>
  #   {"price"=>"161586", "down"=>"12", "schedule"=>"none", "terminmonths"=>"360", "output"=>"xml"},
  #  "message"=>{"text"=>"Request successfully processed", "code"=>"0"},
  #  "response"=>
  #   {"monthlyprincipalandinterest"=>"660",
  #    "monthlypropertytaxes"=>"0",
  #    "monthlyhazardinsurance"=>"0",
  #    "monthlypmi"=>"70",
  #    "monthlyhoadues"=>"0",
  #    "totalmonthlypayment"=>"730",
  #    "totalpayments"=>"262821",
  #    "totalinterest"=>"95457",
  #    "totalprincipal"=>"142196",
  #    "totaltaxesfeesandinsurance"=>"25169"},
  #  "schemaLocation"=>
  #   "http://www.zillow.com/static/xsd/MonthlyPaymentsAdvanced.xsd http://www.zillowstatic.com/vstatic/f7a2366/static/xsd/MonthlyPaymentsAdvanced.xsd"}}



		 # updated_property_result['updatedPropertyDetails']['response']['editedFacts']
			# {"useCode"=>"MultiFamily2To4",
			# "bedrooms"=>"6",
			# "bathrooms"=>"3.0",
			# "finishedSqFt"=>"1914",
			# "yearBuilt"=>"1898",
			# "numFloors"=>"2",
			# "parkingType"=>"Garage - Attached",
			# "numUnits"=>"2"}

		# end

end
