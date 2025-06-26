# frozen_string_literal: true

module BreadcrumbsOnRails
  module Breadcrumbs
    class TailwindBuilder < Builder
      def render
        @context.content_tag(:nav, class: "breadcrumbs text-sm", aria: { label: "Breadcrumb" }) do
          @context.content_tag(:ol, class: "inline-flex items-center space-x-1 md:space-x-3") do
            @elements.collect do |element|
              render_element(element)
            end.join.html_safe
          end
        end
      end

      def render_element(element)
        current = @context.current_page?(compute_path(element))
        aria = current ? { aria: { current: "page" } } : {}

        @context.content_tag(:li, aria) do
          @context.content_tag(:div, class: "flex items-center") do
            link_or_text = @context.link_to_unless_current(compute_name(element), compute_path(element), element.options.merge(class: "ml-1 text-sm font-medium text-slate-700 hover:text-white md:ml-2"))
            divider = @context.content_tag(:span, (@options[:separator] || ">").html_safe, class: "divider") unless current

            link_or_text + (divider || "")
          end
        end
      end
    end
  end
end
