require 'will_paginate'
class SearchController < ApplicationController
	
	def search
		
		@message = ""
		@message2 = "Enter search criteria to browse the database" 
		@selectexp = params[:selectexp]

		@cmpName1 = params[:cmpName1]
		@cmpName2 = params[:cmpName2]
		@cmpName3 = params[:cmpName3]
		@cmpName4 = params[:cmpName4]

		@cmpSubstr = params[:cmpSubstr]
		@pathSubstr = params[:pathSubstr]
		@tarSubstr = params[:tarSubstr]

		if(@cmpName1 == "" || @cmpName1 == nil)
			@cmpName1 = params[:currCmpName]
		elsif (@cmpName2 == "" || @cmpName2 == nil)
			@cmpName2 = params[:currCmpName]
		elsif(@cmpName3 == "" || @cmpName3 == nil) 
			@cmpName3 = params[:currCmpName]
		elsif (@cmpName4 == "" || @cmpName4 == nil)
			@cmpName4 = params[:currCmpName]
		end

		@target = params[:target]
		@pathway = params[:pathway]


		if(@target == nil or @target == "")
			@target = "Any"
		end
		if(@pathway ==nil or @pathway == "")
			@pathway = "Any"
		end


		if(@target == "Any" and @pathway == "Any")
			@info = Info.where('compoundName != ? and compoundName != ? and compoundName != ? and compoundName != ?','Empty','Compound','198','199').order(:compoundName).pluck(:compoundName)
			@targets = Info.where('compoundName != ? and compoundName != ?','Empty','Compound').order(:targetsEdited).pluck(:targetsEdited).uniq
			@targetsParsed = []
			@targets.each do |t|
				if(t != nil)
					values = t.split(';')
					if(values != nil)
						values.each do |v|
							@targetsParsed.append(v.strip)
						end
					end
				end
			end
			@targetsParsed = @targetsParsed.uniq
			@targetsParsed = @targetsParsed.sort()
			@pathways = Info.where('compoundName != ? and compoundName != ?','Empty','Compound').order(:pathway).pluck(:pathway).uniq
		end

		
		if(@target != "Any" and @pathway =="Any")
			@info = Info.where('compoundName != ? and compoundName != ? and targetsEdited LIKE ?','Empty','Compound',@target).order(:compoundName).pluck(:compoundName)
			print "HERE HERE HERE HERE" 
			print @info
			print @target
			@targets = Info.where('compoundName != ? and compoundName != ?','Empty','Compound').order(:targetsEdited).pluck(:targetsEdited).uniq
			@targetsParsed = []
			@targets.each do |t|
				if(t != nil)
					values = t.split(';')
					if(values != nil)
						values.each do |v|
							@targetsParsed.append(v.strip)
						end
					end
				end
			end
			@targetsParsed = @targetsParsed.uniq
			@targetsParsed = @targetsParsed.sort()

			@pathways = Info.where('compoundName != ? and compoundName != ? and targetsEdited = ?','Empty','Compound',@target).order(:pathway).pluck(:pathway).uniq
			
		end

		if (@pathway != "Any" and @target =="Any")
			@info = Info.where('compoundName != ? and compoundName != ? and pathway = ?','Empty','Compound',@pathway).order(:compoundName).pluck(:compoundName)
			print "HERE HER EHERE"
			print @info
			@targets = Info.where('compoundName != ? and compoundName != ? and pathway = ?','Empty','Compound',@pathway).order(:targetsEdited).pluck(:targetsEdited).uniq
			@targetsParsed = []
			@targets.each do |t|
				if(t != nil)
					values = t.split(';')
					if(values != nil)
						values.each do |v|
							@targetsParsed.append(v.strip)
						end
					end
				end
			end
			@targetsParsed = @targetsParsed.uniq
			@targetsParsed = @targetsParsed.sort()

			@pathways = Info.where('compoundName != ? and compoundName != ?','Empty','Compound').order(:pathway).pluck(:pathway).uniq
		end

		if (@pathway != "Any" and @target != "Any")
			@info = Info.where('compoundName != ? and compoundName != ? and pathway = ? and targetsEdited = ?','Empty','Compound',@pathway,@target).order(:compoundName).pluck(:compoundName)
			@targets = Info.where('compoundName != ? and compoundName != ?','Empty','Compound').order(:targetsEdited).pluck(:targetsEdited).uniq
			@targetsParsed = []
			@targets.each do |t|
				if(t != nil)
					values = t.split(';')
					if(values != nil)
						values.each do |v|
							@targetsParsed.append(v.strip)
						end
					end
				end
			end
			@targetsParsed = @targetsParsed.uniq
			@targetsParsed = @targetsParsed.sort()
			
			@pathways = Info.where('compoundName != ? and compoundName != ?','Empty','Compound').order(:pathway).pluck(:pathway).uniq
		end

		@pathways.delete_if {|p| p ==nil}
		@targets.delete_if {|t| t==nil}

		render "search/search"
	end

	
end
