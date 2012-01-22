def import
  data.default_sheet = data.sheets.first

  7.upto(data.last_row) do |line|
    upc = data.cell(line, 'B')
    department_name = data.cell(line, 'D')
    vendor_name = data.cell(line, 'F')
    item_name = data.cell(line, 'H')
    color = data.cell(line, 'J')
    size = data.cell(line, 'L')
    regular_price = data.cell(line, ' N')
    customer_order_quantity = data.cell(line, 'P')
    on_hand_quantity = data.cell(line, 'R')
  end

  puts "Found #{upc} #{department_name}"
end