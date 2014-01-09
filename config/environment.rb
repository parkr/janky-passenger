require "janky"

require "dotenv"
Dotenv.load(File.expand_path("../../.env", __FILE__))

Janky.setup(ENV)
