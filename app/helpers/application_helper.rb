module ApplicationHelper

    def current_path(path)
        "current" if current_page?(path)
    end

    def hide_header?
        controller.class.name == 'ProfilesController' ||
        controller.class.name.split("::").first == "Profile"
    end

end
