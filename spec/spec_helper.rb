require "./config/boot"

ActiveRecord::Base.establish_connection(
  adapter: "sqlite3",
  database: Pathname(__FILE__).dirname.join("percent.sqlite3")
)

Percent::Hooks.init

load Pathname(__FILE__).dirname.join("support/schema.rb")
load Pathname(__FILE__).dirname.join("support/models.rb")
