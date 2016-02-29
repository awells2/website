class CreateConfluences < ActiveRecord::Migration
  def change
    create_table :confluences do |t|
    	t.integer :num
    	t.string :compoundName
    	t.integer :t0
    	t.integer :t2
    	t.integer :t4
    	t.integer :t6
    	t.integer :t8
    	t.integer :t10
    	t.integer :t12
    	t.integer :t14
    	t.integer :t16
    	t.integer :t18
    	t.integer :t20
    	t.integer :t22
    	t.integer :t24
    	t.timestamps
    end
  end
end
