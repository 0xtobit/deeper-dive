class AddSyncedAtToMatch < ActiveRecord::Migration
  def change
    add_column :matches, :synced_at, :timestamp
  end
end
