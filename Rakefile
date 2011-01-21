require 'rubygems'
require 'rake'

begin
	require 'jeweler'
	Jeweler::Tasks.new do |gem|
		gem.name = "super_simple_admin"
		gem.summary = %Q{Provides super simple authentication al a Ryan Bates old screen cast.}
		gem.description = %Q{Provides super simple authentication al a Ryan Bates old screen cast. Creates admin access feature which allows for a single password login for admin tool access.}
		gem.email = "metasoarous@gmail.com"
		gem.homepage = "http://www.thoughtnode.com"
		gem.authors = ["metasoarous"]
		gem.add_dependency "RedCloth"
		gem.add_development_dependency "rspec", ">= 1.2.9"
		gem.add_development_dependency "haml"
		# gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
	end
	Jeweler::GemcutterTasks.new
rescue LoadError
	puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

# task :default => :spec
desc 'Default: Run all specs.'
task :default => :all_specs

desc "Run all specs"
task :all_specs do
	Dir['spec/**/Rakefile'].each do |rakefile|
		directory_name = File.dirname(rakefile)
		sh <<-CMD
			cd #{directory_name} 
			bundle exec rake
		CMD
	end
end


require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
	version = File.exist?('VERSION') ? File.read('VERSION') : ""

	rdoc.rdoc_dir = 'rdoc'
	rdoc.title = "super_simple_admin #{version}"
	rdoc.rdoc_files.include('README*')
	rdoc.rdoc_files.include('lib/**/*.rb')
end