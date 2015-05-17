module ApplicationHelper
	def title
		base_title = "Web Development"
		if @title.nil?
			base_title
		else
			"#{@title} | #{base_title}"			
		end
	end

	def current_user?(user)
	  	user == current_user
	end
end
