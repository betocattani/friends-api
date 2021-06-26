require 'factory_bot_rails'

puts 'Creating users'
FactoryBot.create_list(:user, 20)
