require 'csv'
require 'date'

def numbers_to_weekdays(weekdays)
  for record in weekdays
    if record[0] == 0
      record[0] = 'Monday'
    elsif record[0] == 1
      record[0] = 'Tuesday'
    elsif record[0] == 2
      record[0] = 'Wednesday'
    elsif record[0] == 3
      record[0] = 'Thursday'
    elsif record[0] == 4
      record[0] = 'Friday'
    elsif record[0] == 5
      record[0] = 'Saturday'
    elsif record[0] == 6
      record[0] = 'Sunday'
    end
  end
  weekdays
end

contents = CSV.open(
  '/home/bart/Desktop/Ruby/Odin_projects/event_manager/event_attendees.csv',
  headers: true,
  header_converters: :symbol
)

hours = []
popular_hours = []
weekdays = []
popular_weekdays = []

contents.each do |row|
  regdate = row[:regdate].to_s
  time = DateTime.strptime(regdate, '%m/%d/%Y %H:%M')
  date = DateTime.strptime(regdate, '%m/%d/%Y %H:%M')
  hours << time.hour
  weekdays << date.wday
end

hour_count = Hash.new(0)
hours.each {|hour| hour_count[hour] += 1}
sorted_hours = hour_count.sort_by { |hour,number| number}
popular_hours << sorted_hours[-2..-1]

weekday_count = Hash.new(0)
weekdays.each {|weekday| weekday_count[weekday] += 1}
sorted_weekdays = weekday_count.sort_by { |weekday,number| number}
sorted_weekdays = numbers_to_weekdays(sorted_weekdays)
popular_weekdays << sorted_weekdays[-2..-1]

puts "\nHOURS"
puts "Most popular hour: " + popular_hours[0][-1][0].to_s
puts "2nd most popular hour: " + popular_hours[0][-2][0].to_s

puts "\nDAYS OF THE WEEK"
puts "Most popular day: " + popular_weekdays[0][-1][0].to_s
puts "2nd most popular day: " + popular_weekdays[0][-2][0].to_s
