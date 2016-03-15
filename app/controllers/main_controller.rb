class MainController <ApplicationController
	
	def experimentHome
		@experimentList = Experiment.where('expId != ?', 'expId')

		render :experimentHome
	end 
end
