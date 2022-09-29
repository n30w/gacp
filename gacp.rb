#!/usr/bin/env ruby

add = "git add \."
push = "git push"

system(add)

puts "Added files to Git for staging..."
puts "Add a commit message:"

msg = gets.chomp
until msg
  puts "Please input a valid commit message:"
end

system("git commit -m \"#{msg}\"")
system(push)
