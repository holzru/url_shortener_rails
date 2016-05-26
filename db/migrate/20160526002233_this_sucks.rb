class ThisSucks < ActiveRecord::Migration
  def change
    add_column :tag_topics, :body, :string
  end
end
