class CreateShortUrls < ActiveRecord::Migration[7.0]
  def change
    create_table :short_urls do |t|
      t.string :slug, unique: true
      t.string :url
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
