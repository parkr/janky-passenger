require "janky"

require "dotenv"
Dotenv.load(File.expand_path("../../.env", __FILE__))

http.verify_mode = OpenSSL::SSL::VERIFY_NONE

Janky.setup(ENV)
