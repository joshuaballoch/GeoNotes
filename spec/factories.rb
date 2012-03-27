# By using the symbol ':user' we get Factory girl to simulate the user model.
Factory.define :user do |user|
  user.username "JimBobJoe"
  user.email "jimbobjoe.erie@email.org"
  user.password "hUllo9jim"
  user.password_confirmation "hUllo9jim"
end
Factory.define :user2 do |user|
  user.username "JimffBobJoe"
  user.email "jimbobjoffe.erie@email.org"
  user.password "hUllo9jim"
  user.password_confirmation "hUllo9jim"
end
Factory.define :user3 do |user|
  user.username "JimffBfobJoe"
  user.email "jimbobjofsfe.erie@email.org"
  user.password "hUllo9jim"
  user.password_confirmation "hUllo9jim"
end