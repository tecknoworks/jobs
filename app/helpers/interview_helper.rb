module InterviewHelper
  def interview_status_select_values
    [
      ['pass', Interview::PASS],
      ['fail', Interview::FAIL]
    ]
  end
end
