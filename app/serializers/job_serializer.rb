class JobSerializer < ActiveModel::Serializer
  attributes :id, :status, :hired_candidates_count, :rejected_candidates_count, :ongoing_candidates_count

  def hired_candidates_count
    object.applications.hired.count
  end

  def rejected_candidates_count
    object.applications.rejected.count
  end

  def ongoing_candidates_count
    object.applications.ongoing.count
  end
end
