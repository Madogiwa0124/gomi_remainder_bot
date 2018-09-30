require 'sinatra'
require 'line/bot'
require_relative 'line_client'
require_relative 'gomi_checker'

get '/' do
  "Server Running"
end

def client
  @client ||= LineClient.new
end

post '/callback' do
  body = request.body.read

  signature = request.env['HTTP_X_LINE_SIGNATURE']
  unless client.validate_signature(body, signature)
    error 400 do 'Bad Request' end
  end

  events = client.parse_events_from(body)
  events.each do |event|
    case event
    when Line::Bot::Event::Message
      client.reply(event['replyToken'], GomiChecker.notice_message)
    end
  end
  puts "OK"
end
