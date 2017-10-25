User.delete_all
Company.delete_all

User.create(
  email: "felix.ottander@yahoo.com",
  first_name: "Felix",
  last_name: "Ottander",
  phone: "07328724334",
  password: "123456"
  )

Company.create(
  email: "info@buildingblockz.se",
  name: "Billnodix",
  username: "Anders p",
  address: "Södra gatan 33",
  zip_code: "41267",
  city: "Göteborg",
  org_number: "3423443453",
  phone: "079347238723",
  password: "123456"
)

puts "Created #{Company.count} company"
puts "Created #{User.count} user"
