# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
FansHome::Application.initialize!

FansHome::Application.configure do
  config.gem "mongo_mapper",:source=>"http://gemcutter.org"
  config.frameworks = [:active_record] # - 代表不加载 active_record
end