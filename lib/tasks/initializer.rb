ActiveRecord::Base.connection.execute("TRUNCATE TABLE line_items")
ActiveRecord::Base.connection.execute("TRUNCATE TABLE products")
ActiveRecord::Base.connection.execute("TRUNCATE TABLE rack_counts")