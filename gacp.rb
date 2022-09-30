#!/usr/bin/env ruby

# TODO:
# Add more options for gacp

require 'rubygems'
require 'bundler/setup'
require 'colorized_string'

ColorizedString.colors                       # return array of all possible colors names
ColorizedString.modes                        # return array of all possible modes
ColorizedString.disable_colorization = false

def cute(*cmd)
  # https://www.geeksforgeeks.org/closures-in-ruby/
  out = -> do
    # Returns stdout on success, false on failure, nil on error
    # Nabbed from https://bit.ly/3fy0YEh
    begin
      stdout, stderr, status = Open3.capture3(*cmd)
      strip = stdout.slice!(0..-(1 + $/.size)) # strip trailing eol
      if status.success? && strip
        status.success?
      elsif status.sucesss? == false && strip
        stderr
      end
    rescue
    end
  end

  if out.instance_of? String
    puts out
  end
end

expect = ColorizedString.new("> ").yellow

cute "bundle update --all" # https://bundler.io/man/bundle-update.1.html

system "git add \."
puts "✅ Added files to Git for staging"

c = ColorizedString.new("Please input a valid commit message:").red

puts "📝 Commit message:"
print expect
msg = gets.chomp
until msg.length > 1 do
  puts "🤨 " + c
  print expect
end

c = ColorizedString.new("Success").light_green + "! Pushed to Github 🤓"

system "git commit -m \"#{msg}\""
puts "💍 Committed 💒"
puts "pushing..."
cute "git push"
puts "📍 " + c
