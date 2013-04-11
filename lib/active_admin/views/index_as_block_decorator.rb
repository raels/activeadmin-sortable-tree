module ActiveAdmin
  module Views
    IndexAsBlock.class_eval do

      def build(page_presenter, collection)
        add_class "index"
        if active_admin_config.dsl.sortable_options
          resource_name = active_admin_config.resource_name.underscore.parameterize('_')
          set_attribute "data-sortable-type", "plain"
          set_attribute "data-sortable-url", (url_for([:sort, ActiveAdmin.default_namespace, resource_name.pluralize]))
          collection.sort_by! do |a|
            a.send(active_admin_config.dsl.sortable_options[:sorting_attribute]) || 1
          end
        end
        resource_selection_toggle_panel if active_admin_config.batch_actions.any?
        collection.each do |obj|
          instance_exec(obj, &page_presenter.block)
        end
      end

    end
  end
end
