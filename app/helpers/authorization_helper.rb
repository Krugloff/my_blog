module AuthorizationHelper
  def client?
    @user.try :persisted?
  end

  def owner?
    resource = instance_variable_get ?@ + controller_name.singularize
    @user.try(:owner?, resource) || admin?
  end

  def admin?
    @user.try :admin?
  end
end