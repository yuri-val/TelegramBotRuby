require 'telegram/bot'
require_relative 'bot_func'

botFunc = BotFunc.new

token = '169785179:AAEAyasHBCeJMDNohiS434tBt6ZOdygwA-0'
Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    case message.text
      when '/start'
        botFunc.sayHello bot, message
      when '/stop'
        botFunc.sayGoodBye bot, message

    end
  end
end
