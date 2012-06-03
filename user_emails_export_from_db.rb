require 'fastercsv'

FasterCSV.open("file.csv", "w") do |csv|
  User.all.each do |object|
    csv << object.email
  end
end