class ExperimentController < ApplicationController

	def experimentHome
	
		@experimentList = Experiment.where('expId != ?', 'expId')
		
		render "experiment/experimentHome"
	end

	def xls
  		if params[:id]
    		send_file("#{Rails.root}/public/#{params[:id]}.csv", 
            filename: "#{params[:id]}.csv", 
            type: 'application/excel', 
            disposition: 'attachment')
    	end
	end
end
