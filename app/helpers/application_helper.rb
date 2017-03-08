module ApplicationHelper

	def flash_type(key)
		case key
		when "success" then "success" # green
      when "info" then "info"       # blue
      when "notice" then "info"     # blue
      when "warning" then "warning" # yellow
      when "alert" then "warning"   # yellow
      when "danger" then "danger"   # red
      when "error" then "danger"    # red
    end
	end

	def active?(path)
		if current_page?(path)
			"active"
		end
	end

end
