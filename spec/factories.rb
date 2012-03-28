# By using the symbol ':user' we get Factory girl to simulate the user model.
Factory.define :user do |user|
  user.username "JimBobJoe"
  user.email "jimbobjoe.erie@email.org"
  user.password "hUllo9jim"
  user.password_confirmation "hUllo9jim"
end
Factory.sequence :email do |n|
  "anotheremail-#{n}@email.com"
end
Factory.sequence :username do |n|
  "JimBobJoe-#{n}"
end