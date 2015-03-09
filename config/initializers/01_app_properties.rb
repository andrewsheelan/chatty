
# First File loaded by app

Rails.application.config.app_properties = {}
Rails.application.config.app_properties[:hostname] = `hostname`.chop rescue 'unknown-host'

# Load and set app properties for Rails environment

begin
	config = YAML.load_file(File.join(Rails.root, 'config', 'app_properties.yml')) 

	config[Rails.env].each do |key,value|
	  if /password/i.match(key) or /secret/i.match(key) or /sensitive/i.match(key)
	    value = Cypher.decrypt(value)
	  end

	  ENV[key] 										= value
	  Rails.application.config.app_properties[key] 	= value
	end
rescue
end
