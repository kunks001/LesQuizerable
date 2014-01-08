require 'data_mapper'
require './app/quiz_app'

task :auto_migrate do  
  DataMapper.auto_migrate!
  puts "Auto-migrate complete (data was lost)"
end

task :auto_upgrade do
  DataMapper.auto_upgrade!
  puts "Auto-upgrade complete (no data loss)"
end

task :populate do  
  Admin.create(:email => 'foo@bar.com', 
              :password => 'foobar',
              :password_confirmation => 'foobar'
              )
  Admin.create(:email => 'bar@foo.com', 
              :password => 'foobar',
              :password_confirmation => 'foobar'
              :super_admin => true
              )
  puts "Population complete"
end