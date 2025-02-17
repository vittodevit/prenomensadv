# config/initializers/recaptcha.rb
Recaptcha.configure do |config|
  config.site_key  = "6Ldgw9kqAAAAAGTOtzKw2XgPLwnZZG35HK5hwaK7"
  config.secret_key = "6Ldgw9kqAAAAAHXli4I6S7NNlLqRfSIiyC4_e56V"

  # Uncomment the following line if you are using a proxy server:
  # config.proxy = 'http://myproxy.com.au:8080'
end
