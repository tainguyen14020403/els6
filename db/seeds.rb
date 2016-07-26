User.create!(name:  "Example User",
  email: "example@railstutorial.org",
  password:              "foobar",
  password_confirmation: "foobar",admin: 1)
40.times do |f|
  password = "fakepass"
  email = "example-#{f+1}@railstutorial.org"
  name = "User #{f+1}"
  User.create!(name:  name,
    email: email,
    password:              password,
    password_confirmation: password,admin: 0)
end
Category.create!(name: "Basic 500")
Category.create!(name: "At a Restaurant")
Category.create!(name: "On a trip")
500.times do 
  Word.create!(content: "English", mean: "Vietnamese", category_id: 1)
end
100.times do 
  Word.create!(content: "Restaurant", mean: "Nha hang", category_id: 2)
end
100.times do
  Word.create!(content: "Trip", mean: "Chuyen di", category_id: 3)
end
