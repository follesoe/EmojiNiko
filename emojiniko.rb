require 'date'
require 'erb'

data = {}

since = if ARGV.count == 1 then
          from = Date.parse(ARGV[0])
          "--since'#{from.year}-#{from.month}-1'"
        else "" end

commits = %x(git log #{since} --pretty=format:'%aE;%aD;%s')

def days_in_month(date)
  (Date.new(date.year, 12, 31) << (12 - date.month)).day
end

commits.each_line do |line|
  parts = line.split(';')
  email = parts[0]
  date = Date.parse(parts[1])
  first_in_month = Date.new(date.year, date.month, 1)  
  emojis = parts[2].scan(/:[a-z]+:/)

  unless data.key?(first_in_month) then
    data[first_in_month] = {}
  end

  unless data[first_in_month].key?(email) then
    days = days_in_month(date)
    data[first_in_month][email] = Array.new(days) { Array.new }
  end
  
  data[first_in_month][email][date.day].concat emojis  
end

puts ERB.new(DATA.readlines.join, 0, '>').result(binding)

__END__
<html>
  <head>
    <title><%= "Calendar for project #{File.basename(Dir.getwd)} generated #{Time.now}" %></title>
    <link rel='stylesheet' type='text/css' href='http://hassankhan.github.com/emojify.js/stylesheets/emojify.min.css'>
  </head>
  <body>    
<% 
data.each do |month, user| 
days = days_in_month(month)
%>
    <table>
      <thead>
        <tr>
          <th colspan="<%= days %>"><%= month %></th>
        </tr>
        <tr>
          <th></th>
<% (1..days).each do |day| %>
          <th><%= day %></th>
<% end %>
        </tr>
      </thead>
      <tbody>
<% user.each do |email, emojis_by_date| %>
        <tr>
            <td><%= email %></td>
<% emojis_by_date.each do |emojis| %>
            <td><%= emojis.join(' ') %></td>
<% end %>
        </tr>
<% end %>
      </tbody>
    </table>
<% end %>    
    <script src='http://hassankhan.github.com/emojify.js/javascripts/emojify.min.js'></script>
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