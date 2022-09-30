#!/usr/bin/env ruby

require 'rubygems'
require 'bundler/setup'
require 'colorized_string'

ColorizedString.colors                       # return array of all possible colors names
ColorizedString.modes                        # return array of all possible modes
ColorizedString.disable_colorization = false


# Returns stdout on success, false on failure, nil on error
# Nabbed from https://bit.ly/3fy0YEh
def syscall(*cmd)
  begin
    stdout, stderr, status = Open3.capture3(*cmd)
    status.success? && stdout.slice!(0..-(1 + $/.size)) # strip trailing eol
  rescue
  end
end


# TODO:
# Add more options for gacp

expect = ColorizedString.new("> ").yellow

system "git add \."
puts "✅ Added files to Git for staging"

puts "📝 Commit message:"
print expect
msg = gets.chomp
until msg.length > 1 do
  puts "🤨 " +  ColorizedString.new("Please input a valid commit message:").red
  print expect
end

system "git commit -m \"#{msg}\""
puts "💍 Committed 💒"
system "git push"
puts "📍 " + ColorizedString.new("Success").light_green + "! Pushed to Github 🤓"

