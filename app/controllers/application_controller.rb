class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

	#def r_script
  #		r =  RinRuby.new # establishing a new RinRuby connection
  #		r.eval <<-EOF
  #			x <- "HELLO WORLD"
  #		EOF
	#end 

	def to_hash
    	hash = {}; self.attributes.each { |k,v| hash[k] = v }
    return hash
  end
end
