module SampleHelper
	# Multi line R command with rinruby in sample_helper.rb
	def r_script
		require 'rinruby'
  		r =  RinRuby.new # establishing a new RinRuby connection
  		r.eval << EOF
  			x <- 12345
  			return(x)
 		EOF
	end 
end 
