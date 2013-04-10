desc "This task tries to empty the attending queue"
task :release_queue => :environment do
  puts "Releasing queue"
  num = UserEvent.find(:all, conditions: {status: "failed"}).count
  result = Calendar.retry_old
  puts "#{num} events in queue"
  if result
    puts "all #{num} events unloaded"
  else
    puts "#{UserEvent.find(:all, conditions: {status: "failed"}).count} events remain in the queue" 
  end
end

