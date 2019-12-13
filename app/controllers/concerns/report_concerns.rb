module ReportConcerns
  def set_from_and_to
    @from = 5.days.ago
    @to = Time.now
  end
end
