namespace :db do
  desc "db:migration fakes"
  task :migrate => :environment do
    p 'No. We will not migrate!'
  end
end