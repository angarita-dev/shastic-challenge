require 'zeitwerk'

loader = Zeitwerk::Loader.new
loader.push_dir('./app/models')
loader.push_dir('./app/services')
loader.push_dir("#{__dir__}/lib/api_faker")
loader.setup

def setup
  ApiFaker.new.setup_stub
end

def call
end

