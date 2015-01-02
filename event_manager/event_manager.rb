require "csv"
require "sunlight/congress"
require 'erb'

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5,"0")[0..4]
end

def legislators_by_zipcode(zipcode)
legislators = Sunlight::Congress::Legislator.by_zipcode(zipcode)
end

def clean_phone(phone)
  phone = phone.tr('/\-|\(|\)|\./','').delete(' ')
  if phone.length < 10
    phone = "0000000000"
  elsif phone.length == 10
    return phone
  elsif phone.length == 11
    if phone[0] == 1
      phone = phone[1..10]
    else
      phone = "0000000000"
    end
  end
  return phone
end


def save_thank_you_letters(id,form_letter)
  Dir.mkdir("output") unless Dir.exists? "output"
    filename = "output/thanks_#{id}.html"

    File.open(filename,'w') do |file|
    file.puts form_letter
  end
end

def report_days(days)
  report_days_template = File.read "report_days.erb"
  report_days = ERB.new report_days_template
  final_days_report = report_days.result(binding)

    Dir.mkdir("report") unless Dir.exists? "report"
    filename = "report/report_days.html"

    File.open(filename,'w') do |file|
    file.puts final_days_report
  end
end

def report_hours(hours)
  report_hours_template = File.read "report_hours.erb"
  report_hours = ERB.new report_hours_template
  final_hours_report = report_hours.result(binding)
  
  Dir.mkdir("report") unless Dir.exists? "report"
    filename = "report/report_hours.html"
    File.open(filename,'w') do |file|
      file.puts final_hours_report
    end
end

puts "Welcome to EventManager. Working..."
# establish counting hashes for reports
hours=Hash.new(0)
days=Hash.new(0)

# set up form letter
template_letter = File.read "form_letter.erb"
erb_template = ERB.new template_letter

# open CSV file
contents = CSV.open "event_attendees.csv", headers:true, header_converters: :symbol

#load API key for legislators
Sunlight::Congress.api_key = "e179a6973728c4dd3fb1204283aaccb5"

#process file row by row
contents.each do |row|
  id = row[0]
  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])
  phone = clean_phone(row[:homephone].to_s)
  legislators = legislators_by_zipcode(zipcode)

  #date/time info for reports
  date = DateTime.strptime(row[:regdate],'%m/%d/%y %H:%M')
  hours[date.hour] += 1
  days[date.wday] +=1

  #generate form letters
  form_letter = erb_template.result(binding)
  save_thank_you_letters(id,form_letter)
end

# after processing finished, make reports:
report_hours(hours)
report_days(days)

puts "Processing complete."
puts "Check output/ for letters \nand reports/ for reports"