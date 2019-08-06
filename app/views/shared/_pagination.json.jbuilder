json.pagination do
  json.count collection.count
  json.extract! collection, :limit_value, :total_pages, :current_page, :next_page, :prev_page, :first_page?, :last_page?, :out_of_range?
end
