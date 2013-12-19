module ApplicationHelper
	def status_color(is_dangerous)
		if is_dangerous
			return "danger"
		end
		return "success"
  end

  def enabled_color(is_enabled)
    if is_enabled
      return "primary"
    end
    return "default"
  end
end
