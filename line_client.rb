class LineClient
  require 'line/bot'

  attr_reader :client

  def initialize
    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }
  end

  def reply(token, text)
    client.reply_message(token, text_message(text))
  end

  def push(id, text)
    client.push_message(id, text_message(text))
  end

  def validate_signature(body, signature)
    client.validate_signature(body, signature)
  end

  def parse_events_from(body)
    client.parse_events_from(body)
  end

  def text_message(text)
    {
        "type" => "text",
        "text" => text
    }
  end
end
