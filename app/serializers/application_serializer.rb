class ApplicationSerializer < ActiveModel::Serializer
  attributes :id, :candidate_name, :status, :notes_count, :last_interview_date

  def notes_count
    object.notes.count
  end

  def last_interview_date
    object.interviews.last&.interview_date
  end
end
