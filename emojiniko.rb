require 'date'
require 'erb'

data = {}
month = if ARGV.count == 1 
        then Date.parse(ARGV[0]) 
        else Date.new(Date.today.year, Date.today.month, 1) end

emoji_commits = %x(git log --since='#{month.year}-#{month.month}-1' --pretty=format:'%aE;%aD;%s')

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

days = days_in_month(month.year, month.month)

puts ERB.new(DATA.readlines.join, 0, '>').result(binding)

__END__
<html>
  <head>
    <link rel='stylesheet' type='text/css' href='emojify.css'>
  </head>
  <body>
    <table>
      <thead>
        <tr>
          <th></th>
<% (1..days).each do |day| %>
          <th><%= day %></th>
<% end %>
        </tr>
      </thead>
      <tbody>
<% data.each do |user, emojis_by_date| %>
        <tr>
          <td><%= user %></td>
<% emojis_by_date.each do |emojis| %>
          <td><%= emojis.join(' ') %></td>
<% end %>
        </tr>
<% end %>
      </tbody>
    </table>
    <script src='emojify.js'></script>
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
      emojify.run();
    </script>
  </body>
</html>
