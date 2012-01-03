class Product < ActiveRecord::Base
  has_many :line_Items
  has_many :rack_counts, :through => :line_items
end
