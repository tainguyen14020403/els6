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

500.times do 
  Word.create!(content: "English", mean: "Vietnamese", category_id: 1)
end