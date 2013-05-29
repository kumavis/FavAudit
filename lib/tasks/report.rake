# TODO: move from task args to ENV params ?

require 'csv'

namespace :report do

  desc "build a report of changes for today"
  task :today => :environment do
    puts "Report for today"
    report_data = build_report(Date.today.beginning_of_day, Date.today.end_of_day)
    report_to_csv report_data
  end

  desc "build a report of changes between a (arg0) start_time and an (arg1) end_time"
  def build_report(start_time, end_time)
    puts "Building Report..."
    report = {}
    
    # write headers
    report[:columns] = ["fav food", "fav color"]
    report[:rows] = []
    # write rows
    User.all.each do |user|
      # harvest data
      audits_for_period = user.audits.where(:created_at => start_time..end_time)
      changes_for_fav_food = audits_for_period.where(action:"update").map{|a|a.audited_changes["fav_food"]}.compact
      changes_for_fav_color = audits_for_period.where(action:"update").map{|a|a.audited_changes["fav_color"]}.compact
      # write label and data for row
      report[:rows].push({label: user.name, values: [changes_for_fav_food.size, changes_for_fav_color.size]})
    end

    puts "Report Build Complete."

    return report
  end

  def report_to_csv(report)
    filename = "report.csv"
    CSV.open(filename, "w") do |csv|
      
      # write headers
      csv << report[:columns].prepend("")
      
      # write rows
      report[:rows].each do |row|
        # write label and data for row
        csv << row[:values].prepend( row[:label] )
      end
    end
  end

end