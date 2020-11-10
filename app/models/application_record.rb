require 'active_record'

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  my_env = ENV['ENV'] || 'development'
  db_config = YAML.load_file("db/config.yml")[my_env]

  ActiveRecord::Base.establish_connection(db_config)
  ActiveRecord::Base.connection
end
