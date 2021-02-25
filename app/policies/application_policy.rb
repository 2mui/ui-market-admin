class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    allow_admin_deny_editor
  end

  def show?
    allow_admin_deny_editor
  end

  def create?
    allow_admin_deny_editor
  end

  def new?
    create?
  end

  def update?
    allow_admin_deny_editor
  end

  def edit?
    update?
  end

  def destroy?
    allow_admin_deny_editor
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.all
    end

    # def resolve_admin
    #   # scope.where(role: user)
    # end
  end

  private
    def allow_admin_deny_editor
      return true if @user.admin?
      return false if @user.editor?
    end
end
