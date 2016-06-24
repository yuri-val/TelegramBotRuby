require 'telegram/bot'
require_relative 'bot_func'

botFunc = BotFunc.new

config = File.open( 'config.json' ){ |file| file.read }
hConfig = JSON.parse config

token = hConfig['tToken']

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|

    params_ = message.text.split(' ')
    command = params_[0]

    case command
      when '/start'
        botFunc.sayHello bot, message, params_
      when '/stop'
        botFunc.sayGoodBye bot, message, params_
      when '/weather'
        botFunc.sayMeWeather bot, message, params_
      when '/rate'
        botFunc.sayMeExchangeRate bot, message, params_

    end
  end
end
