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
  Admin.all.each {|a| a.destroy }
  Admin.create(:email => 'test@test.com', 
              :password => 'foobar',
              :password_confirmation => 'foobar',
              :super_admin => false
              )
  Admin.create(:email => 'foo@bar.com', 
              :password => 'foobar',
              :password_confirmation => 'foobar',
              :super_admin => true
              )
  puts "Population complete"
end