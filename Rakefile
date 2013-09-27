require 'rake'
require 'rspec/core/rake_task'
 
RSpec::Core::RakeTask.new(:spec) do |rake_task|
	rake_task.pattern = '*_spec.rb'
end
 
task :default  => :spec
