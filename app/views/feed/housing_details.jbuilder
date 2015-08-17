json.array! @responses do |response|
  response = response.first if response.class == Array
  json.zpid response['zpid']
  json.street response['address']['street']
  json.city response['address']['city']
  json.state response['address']['state']
  json.zipcode response['address']['zipcode']
  json.use_code response['useCode']
  if(response['zestimate'])
    json.last_updated response['zestimate']['last_updated']
    json.zestimate_amount response['zestimate']['amount']['__content__']  if response['zestimate']['amount']
    json.valuation_range_high response['zestimate']['valuationRange']['high']['__content__'] if response['zestimate']['valuationRange'] && response['zestimate']['valuationRange']['high']
    json.valuation_range_low response['zestimate']['valuationRange']['low']['__content__'] if response['zestimate']['valuationRange'] && response['zestimate']['valuationRange']['high']
    json.valuation_change response['zestimate']['valueChange']['__content__'] if response['zestimate']['valueChange']
  end
  json.home_details response['links']['homedetails']
  json.graphs_and_data response['links']['graphsanddata']
  json.map_this_home response['links']['mapthishome']
  json.tax_assessment_year response['taxAssessmentYear']
  json.tax_assessment response['taxAssessment']
  json.year_built response['yearBuilt']
  json.lot_size_sq_ft response['lotSizeSqFt']
  json.finished_sq_ft response['finishedSqFt']
  json.Bathrooms response['bathrooms']
  json.last_sold_date response['lastSoldDate']
  json.last_sold_price response['lastSoldPrice']['__content__'] if response['lastSoldPrice']
end
