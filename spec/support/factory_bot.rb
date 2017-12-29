# frozen_string_literal: true

require 'factory_bot_rails'

FactoryBot.definition_file_paths = [
  *FactoryBot.definition_file_paths
]

RSpec.configure do |config|
  config.include(FactoryBot::Syntax::Methods)

  config.before(:all) do
    FactoryBot.reload # これがないとfactoryの変更が反映されません
  end
end
