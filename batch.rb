require_relative 'line_client'
require_relative 'gomi_checker'

def client
  @client ||= LineClient.new
end

def push_ids
  ENV['PUSH_TO_ID'].split(',')
end

begin
  push_ids.each { |id| client.push(id, GomiChecker.notice_message) }
rescue => e
  puts "batch exec error ..."
  p e
end

puts "========OK========"
