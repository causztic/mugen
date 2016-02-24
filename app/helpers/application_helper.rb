module ApplicationHelper
	
	DOB = "06-08-1993".to_date

	def current_age
		now = Time.now.utc.to_date
		now.year - DOB.year - ((now.month > DOB.month || (now.month == DOB.month && now.day >= DOB.day)) ? 0 : 1)
	end

end
