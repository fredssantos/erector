module Erector
  class RbHandler < ActionView::TemplateHandler
    def render(template, local_assigns)
      require_dependency File.expand_path(template.filename)
      widget_class = "views/#{template.path_without_format_and_extension}".camelize.constantize
      Erector::RailsWidget.render(widget_class, @view.controller, nil, template.name =~ /^_/)
    end
  end
end

ActionView::Template.register_template_handler :rb, Erector::RbHandler