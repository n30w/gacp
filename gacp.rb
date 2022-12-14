#!/usr/bin/env ruby
require 'rubygems'
require 'bundler/setup'
require 'open3'
require 'colorized_string'
require 'whirly'

ColorizedString.colors                       # return array of all possible colors names
ColorizedString.modes                        # return array of all possible modes
ColorizedString.disable_colorization = false

# TODO:
# Add more options for gacp
# Its called "cute" because thats the second part of "execute"

def cute (cmd)
  # https://www.geeksforgeeks.org/closures-in-ruby/
  out = -> (cmd) do
    begin
      stdout, stderr, status = Open3.capture3(*cmd)
      status.success? && stdout.slice!(0..-(1 + $/.size))
    rescue
    end
  end

  out.call(cmd)

  if out.instance_of? String
    puts out
  end
end

# system "bundle update --all --quiet --major" https://bundler.io/man/bundle-update.1.html
cute("git add \.")
puts "✅ Added files to Git for staging"

c = ColorizedString.new("Please input a valid commit message:").red
expect = ColorizedString.new("> ").yellow
puts "📝 Commit message:"
print expect
msg = gets.chomp
until msg.length > 1 do
  puts "🤨 #{c}"
  print expect
  msg = gets.chomp
end

c = ColorizedString.new("Success!").light_green + " Pushed to Github 🤓"

cute("git commit -m \"#{msg}\"")
puts "💍 👬 Committed 👭 💒"
# cute("git push")
Whirly.start spinner: "dots2", status: "Pushing 🤭", stop: "😇" do
  # %x[git push]
  cute("git push")
end
puts "📍 #{c}"

#test
