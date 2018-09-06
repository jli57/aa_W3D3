class CreateShortenedUrls < ActiveRecord::Migration[5.1]
  def change
    create_table :shortened_urls do |t|
      t.string :long_url, presence: true
      t.string :short_url, presence: true
      t.integer :user_id, presence: true
    end
    add_index :shortened_urls, :user_id
    add_index :shortened_urls, :short_url, unique: true 
  end
end
