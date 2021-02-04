  require './lib/database_connection'
  require 'pg'

class Listing


  attr_reader :listing_id, :name, :free_date , :host_id, :price

  def initialize(listing_id:, name:, free_date:, host_id:, price:)
    @listing_id = listing_id
    @name = name
    @free_date = free_date
    @host_id = host_id
    @price = price
  end

  def self.all
    result = DatabaseConnection.query("SELECT * FROM listings;")
    result.map do |listing|
      Listing.new(listing_id: listing['listing_id'], name: listing['name'], free_date: listing['free_date'], host_id: listing['host_id'], price: listing['price'])
    end

  end

  def self.create(name:, free_date:, price:)
    result = DatabaseConnection.query("INSERT INTO listings (name, free_date, price)
    VALUES ('#{name}', '#{free_date}', '#{price}') RETURNING listing_id, name, free_date, host_id, price;")
    Listing.new(listing_id: result[0]['listing_id'], name: result[0]['name'], free_date: result[0]['free_date'], host_id: result[0]['host_id'], price: result[0]['price'])
  end


  def self.find(listing_id:)
    result = DatabaseConnection.query("SELECT * FROM listings WHERE listing_id = #{listing_id};")
    Listing.new(listing_id: result[0]['listing_id'], name: result[0]['name'], free_date: result[0]['free_date'], host_id: result[0]['host_id'], price: result[0]['price'])
  end

end
