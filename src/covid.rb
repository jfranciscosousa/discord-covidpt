class Covid
  class << self
    def todays_overall_report
      report = fetch_todays_report

      generate_all_report(report)
    end

    def todays_region_report(region)
      report = fetch_todays_report

      generate_region_report(report, region)
    end

    def between_overall_report(start_date, end_date)
      report = fetch_report_between(start_date, end_date)

      generate_all_report(report)
    end

    def between_region_report(start_date, end_date, region)
      report = fetch_report_between(start_date, end_date)

      generate_region_report(report, region)
    end

    private

    def fetch_todays_report
      # go back 12 hours to account for delays in publishing
      today = (Date.today - 0.5).strftime("%Y-%m-%d")

      CovidPT.at(today)
    rescue StandardError
      raise CustomError
    end

    def fetch_report_between(start_date, end_date)
      CovidPT.compare(start_date, end_date)
    rescue StandardError => e
      puts e
      raise CustomError
    end

    # rubocop:disable Metrics/AbcSize
    def generate_all_report(report)
      all_report = report[:overall]

      <<~MESSAGE
        ** BY REGION **

        Cases in the North: #{all_report[:cases_in_north]}
        Deaths in the North: #{all_report[:deaths_in_north]}

        Cases in the Centre: #{all_report[:cases_in_centre]}
        Deaths in the Centre: #{all_report[:deaths_in_centre]}

        Cases in the Lisbon: #{all_report[:cases_in_lisbon]}
        Deaths in the Lisbon: #{all_report[:deaths_in_lisbon]}

        Cases in the Alentejo: #{all_report[:cases_in_alentejo]}
        Deaths in the Alentejo: #{all_report[:deaths_in_alentejo]}

        Cases in the Algarve: #{all_report[:cases_in_algarve]}
        Deaths in the Algarve: #{all_report[:deaths_in_algarve]}

        Cases in Azores: #{all_report[:cases_in_azores]}
        Deaths in Azores: #{report[:deaths_in_azores]}

        Cases in Madeira: #{all_report[:cases_in_madeira]}
        Deaths in Madeira: #{all_report[:deaths_in_madeira]}

        ** TOTALS **

        Total cases: #{all_report[:total_confirmed_cases]}
        Total deaths: #{all_report[:total_deaths]}

        Cases under suspicious: #{all_report[:total_under_suspicion]}
        Awaiting lab results: #{all_report[:awaiting_lab_results]}
      MESSAGE
    end
    # rubocop:enable Metrics/AbcSize

    def generate_region_report(report, region)
      cases_in_region = report[:regional][region]

      cases_in_region ? "Total cases in #{region}: #{cases_in_region}" : "No data for region"
    end
  end
end
