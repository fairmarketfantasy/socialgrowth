module ApplicationHelper
	def status_color(is_dangerous)
		if is_dangerous
			return "danger"
		end
		return "success"
  end

  def enabled_color(is_enabled)
    return "enabled-color" if is_enabled
    return "disabled-color"
  end
end
