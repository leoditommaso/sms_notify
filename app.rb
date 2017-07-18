require 'logger'
require 'twilio-ruby'
require 'yaml'

def twilio_client_with(data)
  Twilio::REST::Client.new data['account_sid'], data['auth_token']
end

environment = ENV['APP_ENV'] || 'testing'
config = YAML::load_file('config/config.yml')[environment]
client = twilio_client_with config['twilio']
logger = Logger.new("log/#{environment}.log")

logger.info "Starting execution..."

File.open(config['destination_numbers_file']) do |file|
  file.each_line do |destination_number|
    begin
      message = client.account.messages.create(
        :body => config['twilio']['body'],
        :to => destination_number.chomp,
        :from => config['twilio']['from']
      )
      logger.info "Message to #{message.to} was succesfully sent."
    rescue Twilio::REST::RequestError => e
      logger.error e.message
    end
  end
end
