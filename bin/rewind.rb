require "English"

module Rewind
  # Matches strings in the general form of "YYYY-MM-DD hh:mm:ss".
  # @return [Regexp]
  DATETIME_RX = /
    (?!<\d)                 # start of a sequence of digits
    (?<year>(?:19|20)\d\d)  # valid years are 1900-2099
    \D?                     # ---
    (?<month>[01]\d)        # valid months are 01-12
    \D?                     # ---
    (?<day>[0-3]\d)         # valid mdays are 01-31
    (?:                     # time-of-day start
      (?:T|\sat\s)?         # ---
      (?<hour>[0-2]\d)      # valid hours are 00-23
      \D?                   # ---
      (?<minute>[0-5]\d)    # valid minutes are 00-59
      (?:                   # optional second
        \D?                 # ---
        (?<second>[0-5]\d)  # valid secs are 00-59
        (?:\D?\d+)?         # optional fractional seconds, will be discarded
        (?<zone>            # optional time zone like -06.00 or Z
          Z
          |
          [+-]\d\d\D?\d\d
        )?
      )
    )?                      # end optional time-of-day
  /x

  # @return [Array<Symbol>] the names of the capture groups in {DATETIME_RX}
  DATETIME_CAPTURES = %i[year month day hour minute second zone]

  # Matches epoch dates from 1000000000..1999999999 (2001-09-08..2033-05-17)
  # @return [Regexp]
  EPOCH_RX = /(?!<\d)1\d{9}\b/

  class NoDateInFilename < StandardError; end

  module_function

  # @param filename [String]
  # @return [Time]
  def parse_date_from_file(filename)
    case filename
    when DATETIME_RX
      md = $LAST_MATCH_INFO.named_captures(symbolize_names: true)
      Time.new(*md.fetch_values(*DATETIME_CAPTURES))
    when EPOCH_RX
      # epoch seconds
      Time.at($LAST_MATCH_INFO.to_s.to_i)
    else
      raise NoDateInFilename, "cannot parse date from filename: #{filename.inspect}"
    end
  end

  # @param (see .parse_date_from_file)
  # @return [String]
  def timestamp_from_file(filename)
    parse_date_from_file(filename).strftime("%Y-%m-%d %H:%M:%S.")
  end
end

if ENV["VSCODE_PID"]
  [
    "ShouldNotMatch_13062025.tar.gz",
    "Screenshot 2025-06-13 at 15.34.31.png",
    "20250613153431.jpg",
    "Report 2025-06-13.csv",
    "Photos-20250613T213431Z-1-001.zip",
    "In the Pale Moonlight [2025.06.13]",
    "backup-2025-06-13T21-34-31-357Z.zip",
    "export-2025-06-13.json",
    "Vancouver_Sun_2025-06-13_Page7.jpg",
    "archive-1749850471.zip",
  ].each do |filename|
    pp Rewind.parse_date_from_file(filename).localtime
  rescue Rewind::NoDateInFilename => err
    warn err.message
  end
end
