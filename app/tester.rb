require "harvested"

  subdomain = 'bambu4a'
  username = 'anthony.icerock@gmail.com'
  password = 'Ice6667'

  harvest = Harvest.hardy_client(subdomain, username, password, options={:ssl => false})


    @tasks = harvest.tasks.all.each {|u| p u }

puts @tasks