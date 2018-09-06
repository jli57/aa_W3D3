class AddNotNullConstraint < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :email, :string, null: false
    change_column :shortened_urls, :user_id, :integer, null: false
    change_column :shortened_urls, :short_url, :string, null: false
    change_column :shortened_urls, :long_url, :string, null: false
    change_column :visits, :shortened_url_id, :integer, null: false
    change_column :visits, :user_id, :integer, null: false
    add_column :shortened_urls, :created_at, :datetime, null: false
    add_column :shortened_urls, :updated_at, :datetime, null: false
  end
end
