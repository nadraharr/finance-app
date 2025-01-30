class ReportsController < ApplicationController
  before_action :set_operations, except: [:index]

  def index
  end

  def report_by_category
  end

  def report_by_dates
  end

  private

  def set_operations
    @operations = Operation.all #use filters
  end
end
