class CreateInfos < ActiveRecord::Migration
  def change
    create_table :experimentInfo do |t|

      t.timestamps
    end
  end
end
