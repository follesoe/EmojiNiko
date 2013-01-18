# encoding: UTF-8

require 'date'

data = {}
month = Date.new(Date.today.year, Date.today.month, 1)

emoji_commits = %x(git log --since='#{month.year}-#{month.month}-1' --pretty=format:'%aE;%aD;%s'  -E --grep ':[a-z]+:')

def days_in_month(year, month)
  (Date.new(year, 12, 31) << (12 - month)).day
end

emoji_commits.each_line do |line|
	parts = line.split(';')
	email = parts[0]
	date = Date.parse(parts[1])
	emojis = parts[2].scan(/:[a-z]+:/)
  
  unless data.key?(email) then    
    days = days_in_month(date.year, date.month)
		data[email] = Array.new(days) { Array.new }
	end

  data[email][date.day].concat emojis  
end

output = """
<html>
  <head>
    <link rel='stylesheet' type='text/css' href='emojify.css'>
    <script src='emojify.js'></script>
  </head>
  <body>
    <table>
      <thead><tr><th></th>
"""

days = days_in_month(month.year, month.month)
(1..days).each do |day|
  output += "<th>#{day}</th>"
end

output += "</tr></thead>\r\n"

data.each do |key, value|
  output += "\t<tr>"
  output += "<td>#{key}</td>"
  value.each do |day|
    output += "<td>"
    day.each do |emoji|
      output += " #{emoji} "
    end
    output += "</td>"
  end
  output += "</tr>\r\n"
end

output += """
</table>
<script>
emojify.setConfig({
    emojify_tag_type: 'div',
    emoticons_enabled: true,
    people_enabled: true,
    nature_enabled: true,
    objects_enabled: true,
    places_enabled: true,
    symbols_enabled: true
});
emojify.run();</script></body></html>
"""
puts output