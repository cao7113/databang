#!/usr/bin/env dbcli runsqlet
# self is Dba::ScriptRunner (lib/dba/script_runner.rb)
# conn is current Dba::ConnectionBuilder
sdb = conn.sequel_db

members = sdb.from(:members)
units = sdb.from(:units)

members.each_with_index do |m, idx|
  r = units.where(name: m[:unit]).first
  unless r
    r = units.insert(name: m[:unit], group: m[:unit])
    puts "==#{idx}: #{r} created"
  else
    puts "==#{idx}: #{m[:unit]} existed"
  end
end

puts "==end"
