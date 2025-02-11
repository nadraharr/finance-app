class OperationPolicy < ApplicationPolicy
  def index?
    user.present?
  end

  def show?
    author?
  end

  def new?
    author?
  end

  def edit?
    author?
  end

  def create?
    author?
  end

  def update?
    author?
  end

  def destroy?
    author?
  end

  private

  def author?
    user.present? && user == record.user
  end
end
