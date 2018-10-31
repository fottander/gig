Category.delete_all
City.delete_all
Application.delete_all
Job.delete_all
Profile.delete_all
User.delete_all
Company.delete_all
Admin.delete_all
Invoice.delete_all

Admin.create(
  email: "info@admin.se",
  password: "123456",
  id: 99999
  )

Category.create(
  name: "Måleri",
  ssyk_code: "1212",
  id: 50
  )

Category.create(
  name: "Bygg",
  ssyk_code: "1213",
  id: 51
  )

Category.create(
  name: "Plåtslageri",
  ssyk_code: "1214",
  id: 52
  )

Category.create(
  name: "Lager",
  ssyk_code: "1215",
  id: 53
  )

Category.create(
  name: "Övrigt",
  ssyk_code: "1216",
  id: 54
  )

City.create(
  name: "Göteborg",
  id: 50
  )

City.create(
  name: "Stockholm",
  id: 51
  )

City.create(
  name: "Malmö",
  id: 52
  )

City.create(
  name: "Annat",
  id: 53
  )

User.create(
  email: "johan@yahoo.com",
  first_name: "Johan",
  last_name: "Persson",
  phone: "07328724334",
  password: "123456",
  pers_num: "8888888888",
  id: 99999
  )

User.create(
  email: "felix@yahoo.com",
  first_name: "Felix",
  last_name: "Ottander",
  phone: "07328724334",
  password: "123456",
  id: 99998
  )

Company.create(
  email: "info@building.se",
  name: "BraBraBygg",
  username: "Greger",
  address: "Norra gatan 33",
  zip_code: "41867",
  city: "Göteborg",
  org_number: "3423443453",
  phone: "079347238723",
  password: "123456",
  id: 99999
  )

Company.create(
  email: "info@billnodix.se",
  name: "Billnodix",
  username: "Anders p",
  address: "Södra gatan 33",
  zip_code: "41267",
  city: "Göteborg",
  org_number: "3423443453",
  phone: "079347238723",
  password: "123456",
  id: 99998
  )

Profile.create(
  id: 99999,
  username: "Johan P",
  age: "1999-09-14",
  title: "Snickare sedan 5 år",
  description: "Jag har precis flyttat till göteborg från stockholm och söker arbete inom bygg och snickeri. Har tidigare arbetat på stora byggbolag och genomfört både mindre husyggen samt större projekt.",
  skill: "bygg, snickeri, tak, plåt ",
  language: "Svenska, engelska, franska",
  license: "B-körkort, truckkörkort",
  education: "Gymnasieutbildning i musik",
  prev_work: "Göteborgs villa och husmåleri ab 6 år. Jobbat lager i 5 år på Mat.se.",
  city_ids: 50,
  category_ids: 51,
  user_id: 99999
  )

Profile.create(
  id: 99998,
  username: "Felix O",
  age: "1988-09-14",
  title: "Erfaren målare från Göteborg",
  description: "Målare på 29 år från Göteborg med lång erfarenhet inom måleri och enklare snickeri. Jag har varit målare på ett antal större firmor under de senaste fem åren. Jag kan även enklare snickeri samt plåtarbeten. Inom måleri är min specialitet utomhusmålning, där jag lett ett antal projekt för de firmor jag varit anställd på. Det har varit många trähus som målats men också större putsfasader och putsrenoveringar. Lång erfarenhet av sprutmålning, både inomhus och utomhus. Jag gillar att jobba i större grupper av personer och trivs med samarbeten. Glad person med hög arbetsmoral.",
  skill: "Målning mer än 5 år, snickeri ca. 3 år. Sprutmålning, utomhusmålning, inomhusmålning.",
  language: "Svenska, engelska, tyska",
  license: "B-körkort",
  education: "Universitetsstudier i ekonomi",
  prev_work: "Göteborgs villa och husmåleri ab 6 år",
  city_ids: 50,
  category_ids: 50,
  user_id: 99998
  )

Job.create(
  title: "Målare sökes",
  description: "Vi söker en erfaren målare med minst 3 års erfarenhet inom utomhusmåleri av fasad. Ska även ha kunskap inom sprutmålning. Vi söker en person som är självgående och jobbar hårt.",
  requirement: "Målning minst 3 år",
  category_ids: 50,
  city_ids: 50,
  budget: "150kr/timma",
  deadline: "2019-01-01",
  when_in_time: "Asap",
  duration: "2veckor",
  hour_day: 8,
  jobtype: "Projekt",
  company_id: 99999,
  company_username: "Greger",
  id: 99999
  )

Job.create(
  title: "Vi söker snickare för 3 månader",
  description: "Snickare som ska utföra husbyggen både inne och utomhus. Takläggning, panelmontering, fönstermontering etc.",
  requirement: "Snickare minst 3 år.",
  category_ids: 51,
  city_ids: 50,
  budget: "Ej specificerat",
  deadline: "2019-01-01",
  when_in_time: "Asap",
  duration: "3 månader",
  hour_day: 5,
  jobtype: "Deltid",
  company_id: 99999,
  company_username: "Greger",
  id: 99998
  )

Job.create(
  title: "Snickare sökes",
  description: "Vi har behov av en snickare i två månader under juni&augusti. Du behöver ha bra kunskap inom husbygge. Speciellt panel och lägga tak.",
  requirement: "Snickeri, panel, takläggning.",
  category_ids: 51,
  city_ids: 50,
  budget: "150kr/timma",
  deadline: "2019-01-01",
  when_in_time: "Asap",
  duration: "2 månader",
  hour_day: 8,
  jobtype: "Projekt",
  company_id: 99998,
  company_username: "Anders P",
  id: 99997
  )

Job.create(
  title: "Snickare/byggledare sökes",
  description: "Vi har ett projekt där vi söker en byggledare. Projektet kommer utföras under 3 veckor i Juni 2018. Personen ska ha goda kunskaper sedan innan att led byggen.",
  requirement: "Byggledare, snickeri, måleri minst 5 år.",
  category_ids: 51,
  city_ids: 50,
  budget: "Ej specificerat",
  deadline: "2019-01-01",
  when_in_time: "Asap",
  duration: "3 veckor",
  hour_day: 9,
  jobtype: "Deltid",
  company_id: 99998,
  company_username: "Anders P",
  id: 99996
  )

Application.create(
  id: 99999,
  message: "Hello I want job please",
  first_day: "2017-09-17",
  last_day: "2017-09-27",
  hired: true,
  complete: true,
  created_at: "2017-11-09 09:58:53",
  updated_at: "2017-11-09 09:59:19",
  company_id: 99999,
  job_id: 99999,
  profile_id: 99998,
  profile_username: "Felix O",
  job_title: "Målare sökes"
  )

Application.create(
  id: 99998,
  message: "Hej jag kan jobba bra!!",
  first_day: "2017-09-17",
  last_day: "2017-09-27",
  salary: 150,
  hired: true,
  complete: false,
  created_at: "2017-09-09 09:58:53",
  updated_at: "2017-09-19 09:59:19",
  company_id: 99999,
  job_id: 99999,
  profile_id: 99999,
  profile_username: "Johan P",
  job_title: "Målare sökes"
  )

Application.create(
id: 99997,
message: "Hej jag tror jag passar för detta kan börja redan måndag",
first_day: "2017-09-17",
last_day: "2017-09-27",
salary: 130,
hired: true,
complete: false,
created_at: "2017-11-07 15:45:50",
updated_at: "2017-11-07 15:46:24",
company_id: 99999,
job_id: 99998,
profile_id: 99999,
profile_username: "Johan P",
job_title: "Vi söker snickare för 3 månader"
)

Application.create(
  id: 99996,
  message: "Hej ge mig jobbet nu!",
  first_day: "2017-09-17",
  last_day: "2017-09-27",
  hired: false,
  complete: false,
  created_at: "2017-09-07 15:45:50",
  updated_at: "2017-09-17 15:46:24",
  job_id: 99998,
  profile_id: 99998,
  profile_username: "Felix O",
  job_title: "Vi söker snickare för 3 månader"
  )

Invoice.create(
  description: "Målning 2 veckor",
  quantity: 100,
  unit: 150,
  amount: 15000,
  first_day: "2017-09-17",
  last_day: "2017-09-27",
  user_reference: "Felix",
  company_reference: "Greger",
  terms: 15,
  age: 29,
  feedback: "Jättebra jobbat! Felix skötte de jobb vi gav honom perfekt. Vi rekommenderar honom starkt!",
  paid: false,
  post: false,
  user_fee: 0.09,
  ocr_number: "123456",
  application_id: 99999,
  job_id: 99999,
  job_title: "Målare sökes",
  profile_id: 99998,
  company_id: 99999,
  profile_username: "Felix O",
  user_id: 99998
  )

Invoice.create(
  description: "Utomhusmålning 2 veckor",
  quantity: 100,
  unit: 100,
  amount: 10000,
  first_day: "2017-10-17",
  last_day: "2017-11-27",
  user_reference: "Felix",
  company_reference: "Greger",
  terms: 15,
  age: 29,
  feedback: "Jättebra jobbat! Vi kommer definitivt anställa honom igen.",
  paid: true,
  post: false,
  salary_paid: true,
  user_fee: 0.1,
  ocr_number: "1234567",
  application_id: 99999,
  job_id: 99999,
  job_title: "Utomhusmålare",
  profile_id: 99998,
  company_id: 99999,
  profile_username: "Felix O",
  user_id: 99998
  )

Invoice.create(
  description: "Snickeri 2 veckor",
  quantity: 50,
  unit: 1000,
  amount: 50000,
  first_day: "2017-10-17",
  last_day: "2017-10-27",
  user_reference: "Felix",
  company_reference: "Anders P",
  terms: 15,
  age: 29,
  feedback: "Bra jobbat, du kommer få jobb hos oss snart igen.",
  paid: true,
  post: false,
  user_fee: 0.08,
  ocr_number: "123456",
  application_id: 99997,
  job_id: 99997,
  job_title: "Snickare sökes",
  profile_id: 99998,
  company_id: 99998,
  profile_username: "Felix O",
  user_id: 99998
  )

Invoice.create(
  description: "Målning 4 veckor",
  quantity: 40,
  unit: 140,
  amount: 3000,
  first_day: "2017-09-17",
  last_day: "2017-09-27",
  user_reference: "Fisken",
  company_reference: "Anders",
  terms: 15,
  age: 29,
  paid: false,
  post: false,
  user_fee: 0.09,
  ocr_number: "12345",
  application_id: 99998,
  job_id: 99998,
  job_title: "Vi söker snickare för 3 månader",
  profile_id: 99998,
  company_id: 99998,
  profile_username: "Felix O",
  user_id: 99998
  )

Invoice.create(
  description: "Snickeri 2 veckor",
  quantity: 100,
  unit: 100,
  amount: 10000,
  first_day: "2017-09-17",
  last_day: "2017-09-27",
  user_reference: "Johan P",
  company_reference: "Anders P",
  terms: 15,
  age: 19,
  feedback: "Grymt jobbat, vi hoppas du söker fler jobb hos oss.",
  paid: true,
  post: false,
  salary_paid: true,
  user_fee: 0.1,
  ocr_number: "1234",
  application_id: 99997,
  job_id: 99997,
  job_title: "Snickare sökes",
  profile_id: 99999,
  company_id: 99998,
  profile_username: "Johan P",
  user_id: 99999
  )

Invoice.create(
  description: "Snickeri 4 veckor",
  quantity: 40,
  unit: 140,
  amount: 3000,
  first_day: "2017-09-17",
  last_day: "2017-09-27",
  user_reference: "Johan P",
  company_reference: "Anders P",
  terms: 15,
  age: 19,
  paid: false,
  post: false,
  user_fee: 0.1,
  ocr_number: "123",
  application_id: 99996,
  job_id: 99997,
  job_title: "Snickare sökes",
  profile_id: 99999,
  company_id: 99998,
  profile_username: "Johan P",
  user_id: 99999
  )

User.first.confirm
User.last.confirm
Company.first.confirm
Company.last.confirm

puts "Created #{Category.count} category"
puts "Created #{City.count} city"
puts "Created #{Company.count} company"
puts "Created #{User.count} user"
puts "Created #{Job.count} job"
puts "Created #{Admin.count} admin"
puts "Created #{Application.count} application"
puts "Created #{Invoice.count} invoice"
