class CreateShortUrlMetrics < ActiveRecord::Migration[7.0]
  def change
    create_table :short_url_metrics do |t|
      t.json :body
      t.references :short_url, foreign_key: true

      t.timestamps
    end
  end
end
