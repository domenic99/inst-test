class CreateApplicationEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :application_events do |t|
      t.references :application
      t.date :interview_date
      t.date :hire_date
      t.text :content

      t.timestamps
    end
  end
end
