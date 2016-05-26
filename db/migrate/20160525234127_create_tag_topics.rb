class CreateTagTopics < ActiveRecord::Migration


  def change
    change_table :tag_topics do |t|
      t.string :topic
      t.timestamps null: false
    end
  end
end
