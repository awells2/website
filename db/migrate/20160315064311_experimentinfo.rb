class Experimentinfo < ActiveRecord::Migration
	def change
		create_table:experimentinfo do |t|
			t.integer :expId
			t.string :expType
			t.string :researcher
			t.string :description
			t.string :title
			t.string :timeFormat
			t.string :markers
			t.string :cellLine
			t.string :excelName	
		end
	end
end


