class RealEstateData
	attr_reader :data
  def initialize (formatted_addresses)
  	@deep_responses = deep_search_for formatted_addresses
  	return if @deep_responses.count == 0
  	merge_data
  end

  private

  def deep_search_for formatted_addresses
		formatted_addresses.map do |address|
			result = ZillowService.get_deep_search_results address[:address1], address[:zip]
			search_result = result ? result["searchresults"]["response"]["results"]["result"] : result
			search_result.class == Array ? search_result.first : search_result
		end.compact
  end

  def merge_data
  	@data = []
  	@deep_responses.each_with_index do |response, i|
  		data_set = empty_data_set.merge(
				zpid: response['zpid'],
				street: response['address']['street'],
				city: response['address']['city'],
				state: response['address']['state'],
				zipcode: response['address']['zipcode'],
				use_code: response['useCode'],
  			home_details: response['links']['homedetails'],
				graphs_and_data: response['links']['graphsanddata'],
				map_this_home: response['links']['mapthishome'],
				tax_assessment_year: response['taxAssessmentYear'],
				tax_assessment: response['taxAssessment'],
				year_built: response['yearBuilt'],
				lot_size_sq_ft: response['lotSizeSqFt'],
				finished_sq_ft: response['finishedSqFt'],
				bathrooms: response['bathrooms'],
				bedrooms: response['bedrooms'],
				total_rooms: response['totalRooms'],
				last_sold_date: response['lastSoldDate']
  		)
				data_set.merge!( last_sold_price: response['lastSoldPrice']['__content__']) if response['lastSoldPrice']
	  		if response['zestimate']
					data_set[:zestimate][:last_updated] = response['zestimate']['last_updated']
					data_set[:zestimate][:percentile] = response['zestimate']['percentile']
					data_set[:zestimate][:amount] = response['zestimate']['amount']['__content__'] if response['zestimate']['amount']
					data_set[:zestimate][:value_change] = response['zestimate']['valueChange']['__content__'] if response['zestimate']['valueChange']
					data_set[:zestimate][:valuation_range_high] = response['zestimate']['valuationRange']['high']['__content__'] if response['zestimate']['valuationRange'] && response['zestimate']['valuationRange']['high']
					data_set[:zestimate][:valuation_range_low] = response['zestimate']['valuationRange']['low']['__content__'] if response['zestimate']['valuationRange'] && response['zestimate']['valuationRange']['low']
	  		end

	  		monthly_payments_response = ZillowService.calculate_monthly_payments data_set[:zestimate][:amount]
				if monthly_payments_response && monthly_payments_response["paymentsdetails"] && monthly_payments_response["paymentsdetails"]["response"]
					data_set[:calculator][:monthly_principal_and_interest] = monthly_payments_response["paymentsdetails"]["response"]["monthlyprincipalandinterest"]
					data_set[:calculator][:monthly_property_taxes] = monthly_payments_response["paymentsdetails"]["response"]["monthlypropertytaxes"]
					data_set[:calculator][:monthly_hazard_insurance] = monthly_payments_response["paymentsdetails"]["response"]["monthlypropertytaxes"]
					data_set[:calculator][:monthly_p_m_i] = monthly_payments_response["paymentsdetails"]["response"]["monthlypmi"]
					data_set[:calculator][:total_monthly_payment] = monthly_payments_response["paymentsdetails"]["response"]["totalmonthlypayment"]
					data_set[:calculator][:total_payments] = monthly_payments_response["paymentsdetails"]["response"]["totalpayments"]
					data_set[:calculator][:total_interest] = monthly_payments_response["paymentsdetails"]["response"]["totalinterest"]
					data_set[:calculator][:total_taxes_fees_and_insurance] = monthly_payments_response["paymentsdetails"]["response"]["totaltaxesfeesandinsurance"]
				end

	  		@data << data_set
  	end
  end

  def empty_data_set
  	{
			zpid: '',
			street: '',
			city: '',
			state: '',
			zipcode: '',
			use_code: '',
			home_details: '',
			graphs_and_data: '',
			map_this_home: '',
			tax_assessment_year: '',
			tax_assessment: '',
			year_built: '',
			lot_size_sq_ft: '',
			finished_sq_ft: '',
			bathrooms: '',
			bedrooms: '',
			total_rooms: '',
			last_sold_date: '',
			last_sold_price: '',
			zestimate: {
				last_updated: '',
				percentile: '',
				amount: '',
				valuation_range_high: '',
				valuation_range_low: '',
				value_change: '',
			},
			calculator: {
				monthly_principal_and_interest: '',
				monthly_property_taxes: '',
				monthly_hazard_insurance: '',
				monthly_p_m_i: '',
				total_monthly_payment: '',
				total_payments: '',
				total_interest: '',
				total_taxes_fees_and_insurance: ''
			}
  	}
  end
end
