class Covid
  class << self
    # rubocop:disable Metrics/AbcSize
    def overall_report
      report = fetch_todays_report[:overall]

      <<~MESSAGE
        ** BY REGION **

        Cases in the North: #{report[:cases_in_north]}
        Deaths in the North: #{report[:deaths_in_north]}

        Cases in the Centre: #{report[:cases_in_centre]}
        Deaths in the Centre: #{report[:deaths_in_centre]}

        Cases in the Lisbon: #{report[:cases_in_lisbon]}
        Deaths in the Lisbon: #{report[:deaths_in_lisbon]}

        Cases in the Alentejo: #{report[:cases_in_alentejo]}
        Deaths in the Alentejo: #{report[:deaths_in_alentejo]}

        Cases in the Algarve: #{report[:cases_in_algarve]}
        Deaths in the Algarve: #{report[:deaths_in_algarve]}

        Cases in Azores: #{report[:cases_in_azores]}
        Deaths in Azores: #{report[:deaths_in_azores]}

        Cases in Madeira: #{report[:cases_in_madeira]}
        Deaths in Madeira: #{report[:deaths_in_madeira]}

        ** TOTALS **

        Total cases: #{report[:total_confirmed_cases]}
        Total deaths: #{report[:total_deaths]}

        Cases under suspicious: #{report[:total_under_suspicion]}
        Awaiting lab results: #{report[:awaiting_lab_results]}
      MESSAGE
    end
    # rubocop:enable Metrics/AbcSize

    def report_by_region(region)
      report = fetch_todays_report[:regional]
      cases_in_region = report[region]

      cases_in_region ? "Total cases in #{region}: #{cases_in_region}" : "No data for region"
    end

    private

    def fetch_todays_report
      # go back 12 hours to account for delays in publishing
      today = (Date.today - 0.5).strftime("%Y-%m-%d")

      CovidPT.at(today)
    rescue StandardError
      event.respond "No report for that date! Check back later."
    end
  end
end
