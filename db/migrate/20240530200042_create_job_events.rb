class CreateJobEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :job_events do |t|
      t.references :job

      t.timestamps
    end
  end
end
