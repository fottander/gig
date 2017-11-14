Application.delete_all
Job.delete_all
Profile.delete_all
User.delete_all
Company.delete_all

User.create(
  email: "felix.ottander@yahoo.com",
  first_name: "Felix",
  last_name: "Ottander",
  phone: "07328724334",
  password: "123456",
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
  contact: "Mikael",
  id: 99999
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
  password: "123456",
  contact: "felix",
  id: 99998
  )

Profile.create(
  id: 99999,
  username: "Johan P",
  title: "Snickare sedan 5 år",
  description: "Jag har precis flyttat till göteborg från stockholm och söker arbete inom bygg och snickeri. Har tidigare arbetat på stora byggbolag och genomfört både mindre husyggen samt större projekt.",
  skill: "bygg, snickeri, tak, plåt ",
  rate: "Minst 160kr/timma",
  category: "Snickare",
  city: "Göteborg",
  user_id: 99999
  )

Profile.create(
  id: 99998,
  username: "Fisken",
  title: "Målare från gbg",
  description: "Målare på 29 år från gbg med lång erfarenhet inom måleri och snickeri. Har varit målare på ett antal större firmor under 5 år. Kan enklare snickeri samt plåtarbeten. Kan mestadels utomhusmåleri men även enklare inomhusjobb.",
  skill: "målning 5 år, snickeri 3 år. ",
  rate: "runt 150kr/timma",
  category: "Målare",
  city: "Göteborg",
  user_id: 99998
  )

Job.create(
  title: "Målare sökes",
  description: "Vi söker en erfaren målare med minst 3 års erfarenhet inom utomhusmåleri av fasad. Ska även ha kunskap inom sprutmålning. Vi söker en person som är självgående och jobbar hårt.",
  requirement: "Målning minst 3 år",
  category: "Målare",
  city: "Göteborg",
  budget: "150kr/timma",
  deadline: "2019-01-01",
  duration: "2veckor",
  hour_week: "45",
  company_id: 99999,
  company_username: "Greger",
  id: 99999
  )

  Job.create(
    title: "Vi söker snickare för 3 månader",
    description: "Snickare som ska utföra husbyggen både inne och utomhus. Takläggning, panelmontering, fönstermontering etc.",
    requirement: "Snickare minst 3 år.",
    category: "Snickare",
    city: "Göteborg",
    budget: "Ej specificerat",
    deadline: "2019-01-01",
    duration: "3 månader",
    hour_week: "45",
    company_id: 99999,
    company_username: "Greger",
    id: 99998
    )

Job.create(
  title: "Snickare sökes",
  description: "Vi har behov av en snickare i två månader under juni&augusti. Du behöver ha bra kunskap inom husbygge. Speciellt panel och lägga tak.",
  requirement: "Snickeri, panel, takläggning.",
  category: "Snickare",
  city: "Göteborg",
  budget: "150kr/timma",
  deadline: "2019-01-01",
  duration: "2 månader",
  hour_week: "45",
  company_id: 99998,
  company_username: "Anders P",
  id: 99997
  )

  Job.create(
    title: "Snickare/byggledare sökes",
    description: "Vi har ett projekt där vi söker en byggledare. Projektet kommer utföras under 3 veckor i Juni 2018. Personen ska ha goda kunskaper sedan innan att led byggen.",
    requirement: "Byggledare, snickeri, måleri minst 5 år.",
    category: "Snickare",
    city: "Göteborg",
    budget: "Ej specificerat",
    deadline: "2019-01-01",
    duration: "3 veckor",
    hour_week: "50",
    company_id: 99998,
    company_username: "Anders P",
    id: 99996
    )

Application.create(
  id: 99999,
  message: "Hello I want job please",
  hired: true,
  complete: true,
  created_at: "2017-11-09 09:58:53",
  updated_at: "2017-11-09 09:59:19",
  job_id: 99999,
  profile_id: 99998,
  profile_username: "Fisken",
  job_title: "Målare sökes"
  )

  Application.create(
    id: 99998,
    message: "Hej jag kan jobba bra!!",
    hired: true,
    complete: false,
    created_at: "2017-09-09 09:58:53",
    updated_at: "2017-09-19 09:59:19",
    job_id: 99999,
    profile_id: 99999,
    profile_username: "Johan P",
    job_title: "Målare sökes"
    )

Application.create(
  id: 99997,
  message: "Hej jag tror jag passar för detta kan börja redan måndag",
  hired: true,
  complete: false,
  created_at: "2017-11-07 15:45:50",
  updated_at: "2017-11-07 15:46:24",
  job_id: 99998,
  profile_id: 99999,
  profile_username: "Johan P",
  job_title: "Vi söker snickare för 3 månader"
  )

  Application.create(
    id: 99996,
    message: "Hej ge mig jobbet nu!",
    hired: false,
    complete: false,
    created_at: "2017-09-07 15:45:50",
    updated_at: "2017-09-17 15:46:24",
    job_id: 99998,
    profile_id: 99998,
    profile_username: "Fisken",
    job_title: "Vi söker snickare för 3 månader"
    )

puts "Created #{Company.count} company"
puts "Created #{User.count} user"
puts "Created #{Job.count} job"
puts "Created #{Application.count} application"
