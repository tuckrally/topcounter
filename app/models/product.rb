class Product < ActiveRecord::Base
  has_many :line_items
  has_many :rack_counts, :through => :line_items

  def self.non_zero
    self.line_items.count - self.on_hand_qty != 0
  end
end
