require 'csv'

WORKS_FILE = Rails.root.join('db', 'media_seeds.csv')
puts "Loading raw media data from #{WORKS_FILE}"

work_failures = []
CSV.foreach(WORKS_FILE, :headers => true) do |row|
  work = Work.new
  work.title = row['title']
  work.author = row['author']
  work.category = row['category']
  work.publication_year = row['publication_year']
  work.description = row['description']
  successful = work.save
  if !successful
    works_failures << work
    puts "Failed to save work: #{work.inspect}"
  else
    puts "Created work: #{work.inspect}"
  end
end

puts "Added #{Work.count} work records"
puts "#{work_failures.length} work failed to save"