require 'rufus-scheduler'
require 'tzinfo'
include GigHelper
# Let's use the rufus-scheduler singleton

scheduler = Rufus::Scheduler.singleton
# scheduler.every '1m' do
#   	TimeZone.each do |zone|
# 		time = TZInfo::Timezone.get(zone[1])
# 		if time.now.strftime("%P") == CronMRD && time.now.strftime("%I:%M") == CronTime
# 		    change_is_active(zone[0])
# 		end
# 	end
# end