class ItemPolicy < ApplicationPolicy
  class Scope < Scope
    # editor can only see records he uploaded, admin can see all
    def resolve
      if @user.admin?
        scope.all
      else
        scope.where(upload_by: @user)
      end
    end
  end

  def index?
    true
  end

  def show?
    true
  end

  def edit?
    true
  end

  def create?
    true
  end

  def update?
    true
  end

  def new?
    true
  end

end
