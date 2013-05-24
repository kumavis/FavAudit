require 'faker'

namespace :admin  do
  desc "create some fake data"
  task :fake_users => :environment do
    print "How many fake people do you want?"
    num_people = $stdin.gets.to_i
    num_people.times do
      User.create(name: Faker::Name.name)
    end
    print "#{num_people} created.\n"
  end

  desc "create some fake data"
  task :fake_favs => :environment do
    User.all.each do |user|
      user.update_attributes(fav_food: Faker::Lorem.words(1)[0], fav_color: Faker::Lorem.words(1)[0])
    end
    print "#{User.all.length} users' favs changed.\n"
  end
end