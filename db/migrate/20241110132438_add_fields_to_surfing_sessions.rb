class AddFieldsToSurfingSessions < ActiveRecord::Migration[7.0]
  def change
    add_column :surfing_sessions, :title, :string
    add_column :surfing_sessions, :max_participants, :integer
    add_column :surfing_sessions, :level_required, :string
    add_column :surfing_sessions, :status, :string, default: "open"
    add_column :surfing_sessions, :wave_height, :float
    add_column :surfing_sessions, :meeting_point, :string
  end
end
