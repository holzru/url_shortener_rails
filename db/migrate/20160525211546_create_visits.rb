class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.integer :shortened_url_id, null: false
      t.integer :user_id
      t.timestamps 
    end
  end
end
