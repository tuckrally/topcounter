class AddIndexes < ActiveRecord::Migration
  def up
    execute "ALTER TABLE `pages_linked_pages` ADD UNIQUE `page_id_linked_page_id` (`page_id`,`linked_page_id`)"
  end

  def down
  end
end
