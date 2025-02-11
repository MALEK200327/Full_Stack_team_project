require "logger"
require "sequel"

unless defined?(DB)
  type = ENV.fetch("APP_ENV", "team10_database")
  path = File.dirname(__FILE__)
  db = "#{path}/#{type}"

  DB = Sequel.sqlite("#{db}.sqlite3",
                     logger: Logger.new("#{db}.log"))
end