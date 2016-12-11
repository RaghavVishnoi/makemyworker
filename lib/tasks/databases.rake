namespace :analytics do	
	namespace :db do
	    task :migrate => :set_custom_db_config_paths do
	      Rake::Task["db:migrate"].invoke
	    end
	end
end	