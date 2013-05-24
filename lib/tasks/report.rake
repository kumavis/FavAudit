
desc "build a report of changes"
task :report => :environment do
  puts "Building Report..."
  User.all.each do |user|
    audits_for_period = user.audits.where(created_at: Date.today.beginning_of_day..Date.today.end_of_day)
    changes_for_fav_food = audits_for_period.where(action:"update").map{|a|a.audited_changes["fav_food"]}.compact
    changes_for_fav_color = audits_for_period.where(action:"update").map{|a|a.audited_changes["fav_color"]}.compact
    print "#{changes_for_fav_food.size} fav_food changes today for #{user.name}\n"
    print "#{changes_for_fav_color.size} fav_color changes today for #{user.name}\n"
  end
end