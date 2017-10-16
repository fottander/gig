User.delete_all

User.create(
  email: "felix.ottander@yahoo.com",
  first_name: "Felix",
  last_name: "Ottander",
  phone: "07328724334",
  password: "123456"
  )

puts "Created #{User.count} user"
