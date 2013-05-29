task :greet, [:guest, :greeting] => :environment do |t, args|
  args.with_defaults( guest: "world", greeting: "Hello" )
  puts "#{args.greeting} #{args.guest}"
end

task :ask => :greet do
  puts "How are you?"
end