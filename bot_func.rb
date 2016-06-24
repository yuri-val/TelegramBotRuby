require 'json'
require 'uri'
require 'net/http'


class BotFunc

  def sayHello bot, message, params_
    bot.api.sendMessage(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}")
  end

  def sayGoodBye bot, message, params_
    bot.api.sendMessage(chat_id: message.chat.id, text: "Good Bye, #{message.from.first_name}")
  end

  def sayMeWeather bot, message, params_

    city = params_[1]

    city = (city.nil? ? "Odessa" : city)

    if city.ascii_only?

      url = URI("http://api.openweathermap.org/data/2.5/weather?q=#{city}&units=metric&appid=#{wToken}")

      http = Net::HTTP.new(url.host, url.port)

      request = Net::HTTP::Get.new(url)
      request["cache-control"] = 'no-cache'
      request["postman-token"] = '5ca1aff9-57ae-6c0c-40b1-49a2997854fd'

      response = http.request(request)
      body = JSON.parse response.read_body
      bot.api.sendMessage(chat_id: message.chat.id, text:  "#{body['name']},#{body['sys']['country']}\nThe temperature is #{body["main"]["temp"]} °C")

    else
      bot.api.sendMessage(chat_id: message.chat.id, text:  "Error! \nWrite the correct name of the city in English!")

    end

  end

  def sayMeExchangeRate bot, message, params_

    url = URI("http://openrates.in.ua/rates")

    http = Net::HTTP.new(url.host, url.port)

    request = Net::HTTP::Get.new(url)
    request["cache-control"] = 'no-cache'
    request["postman-token"] = '60ae9115-8127-c9b7-93da-c09f9e6fc80f'

    emoji = {
            "bank" => "🏦",
            "sell" => "⏫",
            "buy" => "⏬",
            "UAH" => "🇺🇦",
            "USD" => "💵",
            "EUR" => "💶",
            "RUB" => "🇷🇺"
            }

    response = http.request(request)
    body = JSON.parse response.read_body
    resp = "Exhange rate for UAH #{emoji['UAH']}";
    body.each_key do |k_curr|
      resp = resp + "\n\n#{emoji[k_curr]}#{k_curr}:"
      body[k_curr].each_key do |k_bank|
        resp = resp + "\n#{emoji['bank']}#{k_bank}:\n"
        body[k_curr][k_bank].each_key do |k_rate|
          resp = resp + "#{emoji[k_rate]}#{k_rate}: #{body[k_curr][k_bank][k_rate]}\t"
        end
      end
    end
    bot.api.sendMessage(chat_id: message.chat.id, text: resp)

  end

  private
  def wToken
    config = File.open('config.json') { |file| file.read }
    hConfig = JSON.parse config
    hConfig['wToken']
  end



end
