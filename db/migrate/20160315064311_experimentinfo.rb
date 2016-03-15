class Experimentinfo < ActiveRecord::Migration
	def change
		create_table:experimentinfo do |t|
			t.integer :expid
			t.string :exptype
			t.string :researcher
			t.string :description
			t.string :title
			t.string :timeformat
			t.string :markers
			t.string :cellline
			t.string :excelname	
		end
	end
end


