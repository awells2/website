class DataController < ApplicationController
	skip_before_filter :verify_authenticity_token 

	def graph
		

  		@expId = params[:expId]

    	@cmpName1 = params[:cmpName1]
    	@cmpName2 = params[:cmpName2]
    	@cmpName3 = params[:cmpName3]
    	@cmpName4 = params[:cmpName4]

    	@cmpSubstr = params[:cmpSubstr]
    	@pathSubstr = params[:pathSubstr]
    	@tarSubstr = params[:tarSubstr]

		if @cmpSubstr != "" or @pathSubstr != "" or @tarSubstr != ""
			redirect_to :action => 'search', :cmpSubstr => @cmpSubstr, :pathSubstr => @pathSubstr, :tarSubstr => @tarSubstr,
						 :controller => 'search', :cmpName1 => @cmpName1, :cmpName2 => @cmpName2, :cmpName3 => @cmpName3, 
						 :cmpName4=> @cmpName4, :selectexp => @expId
			return
		end

    	@cmpCount = 0
    	if(@cmpName1 != nil and @cmpName1 != "")
    		@cmpCount = @cmpCount + 1
    	end
    	if(@cmpName2 != nil and @cmpName2 != "")
    		@cmpCount = @cmpCount + 1
    	end
    	if(@cmpName3 != nil and @cmpName3 != "")
    		@cmpCount = @cmpCount + 1
    	end
    	if(@cmpName4 != nil and @cmpName4 != "")
    		@cmpCount = @cmpCount + 1
    	end


    	if(@cmpName1 != nil and @cmpName1 != "")

			@casNumber1 = Info.where('compoundName = ? and expId = ?', @cmpName1, "2").pluck(:casNumber)[0]
			@molecularWeight1 = Info.where('compoundName = ? and expId = ?', @cmpName1, "2").pluck(:molecularWeight)[0]
			@form1 = Info.where('compoundName = ? and expId = ?', @cmpName1, "2").pluck(:form)[0]
			@targetsEdited1 = Info.where('compoundName = ? and expId = ?', @cmpName1, "2").pluck(:targetsEdited)[0]
			@moleculeType1 = Info.where('compoundName = ? and expId = ?', @cmpName1, "2").pluck(:moleculeType)[0]
			@information1 = Info.where('compoundName = ? and expId = ?', @cmpName1, "2").pluck(:information)[0]
			@pathway1 = Info.where('compoundName = ? and expId = ?', @cmpName1, "2").pluck(:pathway)[0]
			@url1 = Info.where('compoundName = ? and expId = ?', @cmpName1, "2").pluck(:url)[0]

			@markers1 = Experiment.where('expId = ?', @expId).pluck(:markers).join(",")
			@markerList1 = @markers1.split(',')

			@numMarkers1 = @markers1.count(',')
		

			timeFormat1 = Experiment.where('expId = ?', @expId).pluck(:timeFormat).join("-")
			timeInterval1 = timeFormat1.split('<>')[0].to_i
			totalHrs1 = timeFormat1.split('<>')[1].to_i
			
			numTimePoints1 = (totalHrs1/timeInterval1)

			@timeArray1 = (0..totalHrs1+1).step(timeInterval1).to_a
			#@array1 = Array.new(Array.new(numTimePoints1))
			@array1 = Array.new
	
			(0..@numMarkers1).each do |i|
				currMarker1 = @markers1.split(',')[i]
				case currMarker1
				when 'Confluency'
					dataString1 = Confluence.where('compoundname = ? and expid = ?', @cmpName1, @expId).pluck(:data).join("<>")
				when 'Sytox Green'
					dataString1 = Sytox.where('compoundname = ? and expid = ?', @cmpName1, @expId).pluck(:data).join("<>")
				when 'NLS'
					dataString1 = NLS.where('compoundname = ? and expid = ?', @cmpName1, @expId).pluck(:data).join("<>")
				when 'mCherry'
					dataString1 = Cherry.where('compoundname = ? and expid = ?', @cmpName1, @expId).pluck(:data).join("<>")
				end
			
				innerArray1 = Array.new(numTimePoints1)
				#!!!!!!!!!!!!!!!!!!!!!
				(0..numTimePoints1).each do |j|
					innerArray1[j] = dataString1.split("<>")[j].to_f
				end
				@array1[i] = innerArray1
			end
			marker_array = @markers1.split(',')
			if (marker_array.include?('NLS') and marker_array.include?('Sytox Green'))
				cle_scores_array = calculate_cle_score(Sytox.where('compoundname = ? and expid = ?', @cmpName1, @expId).pluck(:data).join("<>"),NLS.where('compoundname = ? and expid = ?', @cmpName1, @expId).pluck(:data).join("<>"))
				@array1[@array1.length] = cle_scores_array
				@markers1 = @markers1 + ",Lethal Fraction"
				@numMarkers1 = @numMarkers1 + 1
			end
			@map1 = Hash.new
			(0..@numMarkers1).each do |j|
				tempArr1 = @array1[j]
				tempArr1.shift
				@map1[@markers1.split(',')[j]] = tempArr1
			end
			print("HERE")
			print(@map1)
			#respond_to do |format|
			#	format.html
			#	format.csv {send_data @map1.to_csv}
			#end
			if(@cmpCount == 1)
				render "display/displayHome"
			end
		end

		if(@cmpName2 != nil and @cmpName2 != "")

			@casNumber2 = Info.where('compoundName = ? and expId = ?', @cmpName2, "2").pluck(:casNumber)[0]
			@molecularWeight2 = Info.where('compoundName = ? and expId = ?', @cmpName2, "2").pluck(:molecularWeight)[0]
			@form2 = Info.where('compoundName = ? and expId = ?', @cmpName2, "2").pluck(:form)[0]
			@targetsEdited2 = Info.where('compoundName = ? and expId = ?', @cmpName2, "2").pluck(:targetsEdited)[0]
			@moleculeType2 = Info.where('compoundName = ? and expId = ?', @cmpName2, "2").pluck(:moleculeType)[0]
			@information2 = Info.where('compoundName = ? and expId = ?', @cmpName2, "2").pluck(:information)[0]
			@pathway2 = Info.where('compoundName = ? and expId = ?', @cmpName2, "2").pluck(:pathway)[0]
			@url2 = Info.where('compoundName = ? and expId = ?', @cmpName2, "2").pluck(:url)[0]

			@markers2 = Experiment.where('expId = ?', @expId).pluck(:markers).join(",")
			@markerList2 = @markers2.split(',')

			@numMarkers2 = @markers2.count(',')
		

			timeFormat2 = Experiment.where('expId = ?', @expId).pluck(:timeFormat).join("-")
			timeInterval2 = timeFormat2.split('<>')[0].to_i
			totalHrs2 = timeFormat2.split('<>')[1].to_i
			numTimePoints2 = totalHrs2/timeInterval2

			@timeArray2 = (0..totalHrs2).step(timeInterval2).to_a

			#@array2 = Array.new(Array.new(numTimePoints2))
			@array2 = Array.new
			(0..@numMarkers2).each do |i|
				currMarker2 = @markers2.split(',')[i]
				case currMarker2
				when 'Confluency'
					dataString2 = Confluence.where('compoundName = ? and expId = ?', @cmpName2, @expId).pluck(:data).join("<>")
				when 'Sytox Green'
					dataString2 = Sytox.where('compoundName = ? and expId = ?', @cmpName2, @expId).pluck(:data).join("<>")
				when 'NLS'
					dataString2 = NLS.where('compoundName = ? and expId = ?', @cmpName2, @expId).pluck(:data).join("<>")
				when 'mCherry'
					dataString2 = Cherry.where('compoundName = ? and expId = ?', @cmpName2, @expId).pluck(:data).join("<>")
				end
			
				innerArray2 = Array.new(numTimePoints2)
				#!!!!!!!!!!!!!!!!
				(0..numTimePoints2).each do |j|
					innerArray2[j] = dataString2.split("<>")[j].to_f
				end
				@array2[i] = innerArray2
			end
		  

			marker_array = @markers2.split(',') 
			if (marker_array.include?('NLS') and marker_array.include?('Sytox Green'))
				cle_scores_array = calculate_cle_score(Sytox.where('compoundName = ? and expId = ?', @cmpName2, @expId).pluck(:data).join("<>"),NLS.where('compoundName = ? and expId = ?', @cmpName2, @expId).pluck(:data).join("<>"))
				@array2[@array2.length] = cle_scores_array
				@markers2 = @markers2 + ",Lethal Fraction"
				@numMarkers2 = @numMarkers2 + 1
			end

			@map2 = Hash.new
			(0..@numMarkers2).each do |j|
				tempArr2 = @array2[j]
				tempArr2.shift
				@map2[@markers2.split(',')[j]] = tempArr2
			end

			if(@cmpCount == 2 and params[:axisFormat] != 'yes')
				render "display/display2"
				return
			end
			if(@cmpCount == 2 and params[:axisFormat]=='yes')
				render "display/display2SameAxis"
				return
			end
		end



		if(@cmpName3 != nil and @cmpName3 != "")

			@casNumber3 = Info.where('compoundName = ? and expId = ?', @cmpName3, "2").pluck(:casNumber)[0]
			@molecularWeight3 = Info.where('compoundName = ? and expId = ?', @cmpName3, "2").pluck(:molecularWeight)[0]
			@form3 = Info.where('compoundName = ? and expId = ?', @cmpName3, "2").pluck(:form)[0]
			@targetsEdited3 = Info.where('compoundName = ? and expId = ?', @cmpName3, "2").pluck(:targetsEdited)[0]
			@moleculeType3 = Info.where('compoundName = ? and expId = ?', @cmpName3, "2").pluck(:moleculeType)[0]
			@information3 = Info.where('compoundName = ? and expId = ?', @cmpName3, "2").pluck(:information)[0]
			@pathway3 = Info.where('compoundName = ? and expId = ?', @cmpName3, "2").pluck(:pathway)[0]
			@url3 = Info.where('compoundName = ? and expId = ?', @cmpName3, "2").pluck(:url)[0]

			@markers3 = Experiment.where('expId = ?', @expId).pluck(:markers).join(",")
			@markerList3 = @markers3.split(',')

			@numMarkers3 = @markers3.count(',')
		

			timeFormat3 = Experiment.where('expId = ?', @expId).pluck(:timeFormat).join("-")
			timeInterval3 = timeFormat3.split('<>')[0].to_i
			totalHrs3 = timeFormat3.split('<>')[1].to_i
			numTimePoints3 = totalHrs3/timeInterval3

			@timeArray3 = (0..totalHrs3).step(timeInterval3).to_a

			#@array3 = Array.new(Array.new(numTimePoints3))
			@array3 = Array.new
			(0..@numMarkers3).each do |i|
				currMarker3 = @markers3.split(',')[i]
				case currMarker3
				when 'Confluency'
					dataString3 = Confluence.where('compoundName = ? and expId = ?', @cmpName3, @expId).pluck(:data).join("<>")
				when 'Sytox Green'
					dataString3 = Sytox.where('compoundName = ? and expId = ?', @cmpName3, @expId).pluck(:data).join("<>")
				when 'NLS'
					dataString3 = NLS.where('compoundName = ? and expId = ?', @cmpName3, @expId).pluck(:data).join("<>")
				when 'mCherry'
					dataString3 = Cherry.where('compoundName = ? and expId = ?', @cmpName3, @expId).pluck(:data).join("<>")
				end
			
				innerArray3 = Array.new(numTimePoints3)
				#!!!!!!!!!!!!!!!!!!
				(0..numTimePoints3).each do |j|
					innerArray3[j] = dataString3.split("<>")[j].to_f
				end
				@array3[i] = innerArray3
			end
		  	

			marker_array = @markers3.split(',') 
			if (marker_array.include?('NLS') and marker_array.include?('Sytox Green'))
				cle_scores_array = calculate_cle_score(Sytox.where('compoundName = ? and expId = ?', @cmpName3, @expId).pluck(:data).join("<>"),NLS.where('compoundName = ? and expId = ?', @cmpName3, @expId).pluck(:data).join("<>"))
				@array3[@array3.length] = cle_scores_array
				@markers3 = @markers3 + ",Lethal Fraction"
				@numMarkers3 = @numMarkers3 + 1
			end

			@map3 = Hash.new
			(0..@numMarkers3).each do |j|
				tempArr3 = @array3[j]
				tempArr3.shift
				@map3[@markers3.split(',')[j]] = tempArr3
			end

			if(@cmpCount == 3 and params[:axisFormat] != 'yes')
				render "display/display3"
				return
			end
			if(@cmpCount == 3 and params[:axisFormat]=='yes')
				render "display/display3SameAxis"
				return
			end

		end


		if(@cmpName4 != nil and @cmpName4 != "")

			@casNumber4 = Info.where('compoundName = ? and expId = ?', @cmpName4, "2").pluck(:casNumber)[0]
			@molecularWeight4 = Info.where('compoundName = ? and expId = ?', @cmpName4, "2").pluck(:molecularWeight)[0]
			@form4 = Info.where('compoundName = ? and expId = ?', @cmpName4, "2").pluck(:form)[0]
			@targetsEdited4 = Info.where('compoundName = ? and expId = ?', @cmpName4, "2").pluck(:targetsEdited)[0]
			@moleculeType4 = Info.where('compoundName = ? and expId = ?', @cmpName4, "2").pluck(:moleculeType)[0]
			@information4 = Info.where('compoundName = ? and expId = ?', @cmpName4, "2").pluck(:information)[0]
			@pathway4 = Info.where('compoundName = ? and expId = ?', @cmpName4, "2").pluck(:pathway)[0]
			@url4 = Info.where('compoundName = ? and expId = ?', @cmpName4, "2").pluck(:url)[0]

			@markers4 = Experiment.where('expId = ?', @expId).pluck(:markers).join(",")
			@markerList4 = @markers4.split(',')

			@numMarkers4 = @markers4.count(',')
		

			timeFormat4 = Experiment.where('expId = ?', @expId).pluck(:timeFormat).join("-")
			timeInterval4 = timeFormat4.split('<>')[0].to_i
			totalHrs4 = timeFormat4.split('<>')[1].to_i
			numTimePoints4 = totalHrs4/timeInterval4

			@timeArray4 = (0..totalHrs4).step(timeInterval4).to_a

			#@array4 = Array.new(Array.new(numTimePoints4))
			@array4 = Array.new
			(0..@numMarkers4).each do |i|
				currMarker4 = @markers4.split(',')[i]
				case currMarker4
				when 'Confluency'
					dataString4 = Confluence.where('compoundName = ? and expId = ?', @cmpName4, @expId).pluck(:data).join("<>")
				when 'Sytox Green'
					dataString4 = Sytox.where('compoundName = ? and expId = ?', @cmpName4, @expId).pluck(:data).join("<>")
				when 'NLS'
					dataString4 = NLS.where('compoundName = ? and expId = ?', @cmpName4, @expId).pluck(:data).join("<>")
				when 'mCherry'
					dataString4 = Cherry.where('compoundName = ? and expId = ?', @cmpName4, @expId).pluck(:data).join("<>")
				end
			
				innerArray4 = Array.new(numTimePoints4)
				#!!!!!!!!!!!!!!!!!!!!!!!!
				(0..numTimePoints4).each do |j|
					innerArray4[j] = dataString4.split("<>")[j].to_f
				end
				@array4[i] = innerArray4
			end
		  


			marker_array = @markers4.split(',') 
			if (marker_array.include?('NLS') and marker_array.include?('Sytox Green'))
				cle_scores_array = calculate_cle_score(Sytox.where('compoundName = ? and expId = ?', @cmpName4, @expId).pluck(:data).join("<>"),NLS.where('compoundName = ? and expId = ?', @cmpName4, @expId).pluck(:data).join("<>"))
				@array4[@array4.length] = cle_scores_array
				@markers4 = @markers4 + ",Lethal Fraction"
				@numMarkers4 = @numMarkers4 + 1
			end

			@map4 = Hash.new
			(0..@numMarkers4).each do |j|
				tempArr4 = @array4[j]
				tempArr4.shift
				@map4[@markers4.split(',')[j]] = tempArr4
			end

			if(@cmpCount == 4 and params[:axisFormat] != 'yes')
				render "display/display4"
				return
			end
			if(@cmpCount == 4 and params[:axisFormat]=='yes')
				render "display/display4SameAxis"
				return
			end

	
		end

	end

	def calculate_cle_score(sytox_array,nls_array)
		cle_array = Array.new
		sytox_array_n = convert_array_to_numeric(sytox_array)
		nls_array_n = convert_array_to_numeric(nls_array)
		for i in 0..sytox_array_n.length-2
			sytox_max = sytox_array_n[0..i].max
			nls_max = nls_array_n[0..i].max
			cle_array[i] = sytox_max/nls_max
		end
		return cle_array
	end

	def convert_array_to_numeric(array)
		numeric_array = Array.new
		split_array = array.split('<>')
		for i in 0..split_array.length
			numeric_array[i] = split_array[i].to_f
		end
		return numeric_array
	end

end
