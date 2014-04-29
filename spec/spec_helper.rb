require 'simplecov'
SimpleCov.start do
  root File.expand_path(File.join(File.dirname(__FILE__), '..'))
  add_filter '/spec/'
end

require 'traktr'

if File.exist?(File.join(File.dirname(__FILE__), 'spec.yaml'))
  conf = YAML.load_file(File.join(File.dirname(__FILE__), 'spec.yaml'))
  if conf['users'].class == Array && conf['users'].size == 2
    API_KEY  = conf['users'][0]['api_key']
    USERNAME = conf['users'][0]['username']
    PASSWORD = conf['users'][0]['password']

    API_KEY_2  = conf['users'][1]['api_key']
    USERNAME_2 = conf['users'][1]['username']
    PASSWORD_2 = conf['users'][1]['password']
  else
    $stderr.puts "ERROR: Your spec file must match the format shown in 'spec.yaml.sample' in the spec directory!"
    exit 1
  end
else
  $stderr.puts "ERROR: You must configure the 'spec.yaml' file in the spec directory!"
  exit 1
end

# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run_excluding misbehaving: true

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'
end
