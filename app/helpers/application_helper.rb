module ApplicationHelper
	def display_message(message)
		if not message or message == ""
			return ""
		else 
			"<p class = 'message'>#{message}</p>".html_safe
		end
	end

	def to_hash
    	hash = {}; self.attributes.each { |k,v| hash[k] = v }
    	return hash
	end 
end

