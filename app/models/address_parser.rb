class AddressParser

  def self.parse_and_encode(addresses_string, zips_string)
    addresses = addresses_string.split("|").each{|s| s.slice!("\t") }.map {|a| URI.encode(a)}
    zips = zips_string.split("|").each{|s| s.slice!("\t") }.map {|a| URI.encode(a)}
    return nil if addresses.count != zips.count
    addresses.zip zips
  end
end
