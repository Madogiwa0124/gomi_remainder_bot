require_relative 'line_client'
require_relative 'gomi_checker'

def client
  @client ||= LineClient.new
end

begin
  client.push(ENV['PUSH_TO_ID'], GomiChecker.notice_message)
rescue => e
  puts "batch exec error ..."
  p e
end

puts "========OK========"
