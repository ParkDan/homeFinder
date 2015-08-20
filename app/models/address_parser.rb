class AddressParser
  def self.parse_and_encode(addresses)
  	formatted_addresses = []
  	addresses.split("\n").each do | row|
  		split_row = row.split("\t")
			formatted_addresses << { address1: URI.encode(split_row.first), zip: URI.encode(split_row[-2]), price: URI.encode(split_row.last) }
  	end
  	formatted_addresses
  end
end
