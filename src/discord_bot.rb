module DiscordBot
  throw "Lacking required secrets!" unless ENV["TOKEN"] && ENV["CLIENT_ID"]

  @bot = Discordrb::Bot.new(
    token: ENV["TOKEN"],
    client_id: ENV["CLIENT_ID"],
  )

  puts "This bot's invite URL is #{@bot.invite_url}"
  puts "Click on it to invite it to your server"

  @bot.message(start_with: "!covidpt ") do |event|
    region = event.content.delete_prefix("!covidpt").strip

    response = if region == "all"
                 Covid.todays_overall_report
               else
                 Covid.todays_region_report(region)
               end

    event.respond(response)

  rescue CustomError
    event.respond "No report for that date! Check back later."
  end

  def self.run
    @bot.run
  end

  def self.invite_url
    @bot.invite_url
  end
end
