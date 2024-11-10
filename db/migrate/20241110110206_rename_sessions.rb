class RenameSessions < ActiveRecord::Migration[7.0]
  def change
    rename_table :sessions, :surfing_sessions
  end
end
