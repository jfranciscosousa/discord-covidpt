module DiscordBot
  throw "Lacking required secrets!" unless ENV["TOKEN"] && ENV["CLIENT_ID"]

  @bot = Discordrb::Bot.new(
    token: ENV["TOKEN"],
    client_id: ENV["CLIENT_ID"],
  )

  puts "This bot's invite URL is #{@bot.invite_url}"
  puts "Click on it to invite it to your server"

  @bot.message(start_with: "!covidpt ") do |event|
    argument = event.content.delete_prefix("!covidpt").strip

    response = if argument == "all"
                 Covid.overall_report
               else
                 Covid.report_by_region(argument)
               end

    event.respond(response)
  end

  def self.run
    @bot.run
  end

  def self.invite_url
    @bot.invite_url
  end
end
