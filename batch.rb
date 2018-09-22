require 'line/bot'
require_relative 'gomi_checker'

def client
  @client ||= Line::Bot::Client.new { |config|
    config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
    config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
  }
end

def text_message(text)
  {
      "type" => "text",
      "text" => text
  }
end

begin
  client.push_message(ENV['PUSH_TO_ID'], text_message(GomiChecker.notice_message))
rescue => e
  puts "batch exec error ..."
  p e
end

puts "========OK========"
