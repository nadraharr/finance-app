class ReportsController < ApplicationController
  def index
  end

  def generate_report
    if params[:commit] == "By Categories"
      report_by_category
    elsif params[:commit] == "By dates"
      report_by_dates
    end
  end

  def report_by_category
    operations = Operation.joins(:category)
                          .where(odate: report_params[:start]..report_params[:finish])

    selected_categories = report_params[:categories].reject(&:blank?)
    operations = operations.where(category_id: selected_categories) if selected_categories.present?

    operations = operations.group("categories.name").sum(:amount)

    @labels = operations.keys
    @data = operations.values

    render :report_by_category
  end

  def report_by_dates
    operations = Operation.where(odate: report_params[:start]..report_params[:finish])

    selected_categories = report_params[:categories].reject(&:blank?)
    operations = operations.where(category_id: selected_categories) if selected_categories.present?

    operations = operations.group("DATE(odate)").sum(:amount)

    @labels = operations.keys.map(&:to_s)
    @data = operations.values

    render :report_by_dates
  end

  private

  def report_params
    params.permit(:commit, :start, :finish, categories: [])
  end
end
