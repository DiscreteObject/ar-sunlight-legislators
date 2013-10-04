require '../db/config'
require_relative './models/congressperson'

# 1. Given any state, first print out the senators for that state (sorted by last name), then print out the representatives (also sorted by last name). Include the party affiliation next to the name.

state = 'CA'

puts "Senators for #{state}"
Congressperson.where('state = ? and title = ?', state, 'Sen').order('lastname').each { |person| puts person.to_pp }
puts "Representatives for #{state}"
Congressperson.where('state = ? and title = ? and in_office = ?', state, 'Rep', 1).order('lastname').each { |person| puts person.to_pp }

# Given a gender, print out what number and percentage of the senators are of that gender as well as what number and percentage of the representatives, being sure to include only those congresspeople who are actively in office, e.g.:

senators = Congressperson.where('title = ? and in_office = ?', 'Sen', 1)
male_senators = senators.where('gender = ?', 'M')
representatives = Congressperson.where('title = ? and in_office = ?', 'Rep', 1)
male_reps = representatives.where('gender = ?', 'M')
total_senators = senators.length
total_reps = representatives.length
puts
puts "Male Senators: #{male_senators.length} (#{male_senators.length.to_f / total_senators * 100}%)"
puts "Male Representatives: #{male_reps.length} (#{male_reps.length.to_f / total_reps * 100 }%)"


# Print out the list of states along with how many active senators and representatives are in each, in descending order (i.e., print out states with the most congresspeople first).
states = Congressperson.select('state').map { |state_object| state_object.state }.uniq
state_counts = {}
states.each do |state|
  s = senators.where('state = ?', state).length
  r = representatives.where('state = ?', state).length
  state_counts[state] = [s, r]
end
state_counts = state_counts.sort_by{ |k, v| -v[1] }

puts "States by Active Congresspeople:"
state_counts.each do |state|
  puts "#{state[0]}: #{state[1][0]} Senators, #{state[1][1]} Representatives"
end

# For Senators and Representatives, count the total number of each (regardless of whether or not they are actively in office).

puts "Senators: " + Congressperson.where('title = ?', 'Sen').length.to_s
puts "Represenatives: " + Congressperson.where('title = ?', 'Rep').length.to_s


