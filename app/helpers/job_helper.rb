module JobHelper
  def job_status_select_values
    [
      ['draft', Job::DRAFT],
      ['published', Job::PUBLISHED],
      ['filled', Job::FILLED],
      ['expired', Job::EXPIRED],
    ]
  end
end
