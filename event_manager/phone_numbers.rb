require 'csv'

def correct_phone(homephone)
  homephone = homephone.delete("^0-9")
  if homephone.length < 10 || homephone.length > 11
    corrected = 'Bad number'
  elsif homephone.length == 11
    if homephone[0] == '1'
      corrected = homephone[1..-1]
    else
      corrected = 'Bad number'
    end
  else 
    corrected = homephone
  end
  return corrected
end

contents = CSV.open(
  '/home/bart/Desktop/Ruby/Odin_projects/event_manager/event_attendees.csv',
  headers: true,
  header_converters: :symbol
)
CSV.open("/home/bart/Desktop/Ruby/Odin_projects/event_manager/output.csv", "w") do |csv|
  contents.each do |row|
    homephone = row[:homephone].to_s
    homephone = correct_phone(homephone)
    pp homephone
    row[:homephone] = homephone
    csv << row
  end
end
