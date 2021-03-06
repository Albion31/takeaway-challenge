require 'twilio-ruby'
require 'envyable'
require_relative 'order'
Envyable.load('./config/env.yml', 'development')

class Text
  attr_reader :send_text
  TIME_FORMAT = "%H:%M"

  def send_text
    account_sid = ENV['TWILIO_ACCOUNT_SID']
    auth_token = ENV['TWILIO_AUTH_TOKEN']

    @client = Twilio::REST::Client.new account_sid, auth_token
    message = @client.messages.create(
        body: order_summary,
        to: ENV['MY_NUMBER'],
        from: ENV['TWILIO_NUMBER'])

    puts message.sid
  end

  def order_summary
    "Thank you for your order. The estimate delivery time is #{delivery_time}"
  end

  def delivery_time
    (Time.new + 60 * 60).strftime(TIME_FORMAT)
  end
end
 
