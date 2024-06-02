class MakeEventsFollowSingleTableInheritance < ActiveRecord::Migration[7.1]
  def change
    add_column :job_events, :type, :string
    add_column :application_events, :type, :string

    add_index :job_events, :type
    add_index :application_events, :type
  end
end
