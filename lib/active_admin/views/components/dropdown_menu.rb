# frozen_string_literal: true
module ActiveAdmin
  module Views

    # Action List - A button with a drop down menu of links
    #
    # Creating a new action list:
    #
    #     dropdown_menu "Administration" do
    #       item "Edit Details", edit_details_path
    #       item "Edit My Account", edit_my_account_path
    #     end
    #
    # This will create a button with the label "Administration" and
    # a drop down once clicked with 2 options.
    #
    class DropdownMenu < ActiveAdmin::Component
      builder_method :dropdown_menu

      # Build a new action list
      #
      # @param [String] name  The name to display in the button
      #
      # @param [Hash] options A set of options that get passed along to
      #                       to the parent dom element.
      def build(name, options = {})
        options = options.dup

        # Easily set options for the button or menu
        button_options = options.delete(:button) || {}
        menu_options = options.delete(:menu) || {}

        @button = build_button(name, button_options)
        @menu = build_menu(menu_options)

        super(options)
      end

      def item(*args, **kwargs, &block)
        within @menu do
          if block_given?
            li &block
          else
            li link_to(*args, **kwargs)
          end
        end
      end

      private

      def build_button(name, options)
        options[:class] = "#{options[:class]} dropdown_menu_button"

        button name, type: :button, "data-dropdown-toggle": dom_id, "data-dropdown-offset-distance": 3, **options
      end

      def build_menu(options)
        options[:class] = "#{options[:class]} dropdown_menu_list"
        options[:id] = dom_id
        ul(options)
      end

      def dom_id
        "dropdown-#{object_id}"
      end

    end

  end
end
