#!/usr/bin/env ruby
 
require 'net/ping'
require 'net/ssh'
 
addr = '#{your_host}'
 
# initialize
result = []
 
#
pingmon = Net::Ping::External.new(addr)
if pingmon.ping?
  puts 'reachable.'
  result = "0"
else
  puts 'unreachable.'
  result = "1"
end
 
#
sshmon = Net::SSH.start(addr,'#{mon_user}',:keys =>['/path/to/mon_user/.ssh/id_rsa'])
sshret = sshmon.exec! "pwd"
if sshret =~ /#{mon_user}/
  puts 'ssh connetcted.'
  result << "0"
else
  puts 'ssh not connetcted.'
  result << "1"
end
 
#
if result =~ /00/
  puts "#{your_host} active."
else
  puts "#{your_host} problem."
  exit 1
end
