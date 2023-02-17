class AddExpiredAtFieldToShortUrl < ActiveRecord::Migration[7.0]
  def change
    add_column :short_urls, :expired_at, :datetime
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
