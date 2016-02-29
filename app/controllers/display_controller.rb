class DisplayController < ApplicationController
	 skip_before_filter :verify_authenticity_token 
	def displayHome
		render "display/displayHome"
	end
end