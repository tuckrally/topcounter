class RackCount < ActiveRecord::Base
  has_many :line_items
  has_many :products, :through => :line_items
  
  validates_presence_of :rack, :shelf  
end
