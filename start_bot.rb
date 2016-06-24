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
        botFunc.say_hello bot, message, params_
      when '/help'
        botFunc.help_me bot, message, params_
      when '/weather'
        botFunc.say_me_weather bot, message, params_
      when '/rate'
        botFunc.say_me_exchange_rate bot, message, params_
      when '/catImage'
        botFunc.give_me_cat_image bot, message, params_
      when '/image'
        botFunc.give_me_just_image bot, message, params_
      when '/jokes'
        botFunc.make_me_laugh bot, message, params_
      when '/stop'
        botFunc.say_good_bye bot, message, params_
      else
        botFunc.say_i_dont_know bot, message, params_
    end
  end
end
