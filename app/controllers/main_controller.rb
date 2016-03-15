class MainController <ApplicationController
	
	def experimentHome
		@experimentList = Experiment.where('expid != ?', 'expid')

		render :experimentHome
	end 
end
