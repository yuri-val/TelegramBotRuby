require 'json'

class BotFunc

  def sayHello bot, message
    bot.api.sendMessage(chat_id: message.chat.id, text: "Hello, #{bot.from.first_name}")
  end

  def sayGoodBye bot, message
    bot.api.sendMessage(chat_id: message.chat.id, text: "Good Bye, #{message.from.first_name}")
  end

gggg


end