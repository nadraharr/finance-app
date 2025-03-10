class CategoryPolicy < ApplicationPolicy
  def index?
    user.present?
  end

  def show?
    author?
  end

  def new?
    user.present?
  end

  def edit?
    author?
  end

  def create?
    user.present?
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
