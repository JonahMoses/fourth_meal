class Permission < Struct.new(:user)

  def allow?(controller, action)
    return true if anyone_access(controller, action)
    if user
      return true if logged_in_user_access(controller, action)
      # All action/controller combinations do not have permission, then ask if user is admin:
      return true if user.admin?
    end
    false
  end

  def anyone_access(controller, action)
    return true if controller == "sessions"
    return true if controller == "home"
    return true if controller == "restaurants"
    return true if controller == "order_items" && action.in?(%[new create destroy edit update])
    return true if controller == "orders" && action.in?(%w[new create show index guest_purchase guest_confirm_purchase])
    return true if controller == "users" && action.in?(%w[new create show purchase])
    return true if controller == "items" && action.in?(%w[index show])
  end

  def logged_in_user_access(controller, action)
    return true if controller == "orders" && action.in?(%w[purchase confirmation])
    return true if controller == "users" && action.in?(%w[edit update])
    return true if controller == "items" && action.in?(%w[index show])
  end

end
