class ReportsController < ApplicationController
  def index
  end

  def report_by_category
  end

  def report_by_dates
    start_date = params[:start]
    finish_date = params[:finish]
    operations = Operation.where(odate: start_date..finish_date)
                          .group("DATE(odate)")
                          .sum(:amount)
    @labels = operations.keys.map(&:to_s)
    @data = operations.values
  end
end
