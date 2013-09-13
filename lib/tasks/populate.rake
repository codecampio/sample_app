namespace :db do
  desc "Generate users"
  task populate: :environment do
    # Generate fixed users Yitao and Ed
  	yitao = User.create(name: "Yitao", email: "yitao@example.com")
  	ed = User.create(name: "Ed", email: "ed@example.com")

    # Generate 98 additional random users
  	users = [ yitao, ed ]
    users += 98.times.collect do |i|
      name = Faker::Name.name
      email = i < 10 ? name.split.join : "#{name.split.join}@example.com"
      user = User.create(name: name, email: email)
    end

    # Randomize user created_at timestamp
    users.each { |user| user.update(created_at: Date.today - rand(30)) }

    # Generate random posts
    posts = (10*users.count).times.collect do
      (users.sample).posts.create(content: Faker::Lorem.sentence)
    end
  end
end