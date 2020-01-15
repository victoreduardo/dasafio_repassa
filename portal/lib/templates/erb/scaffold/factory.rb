# frozen_string_literal: true

FactoryBot.define do
  factory :<%= singular_name %>, class: <%= class_name %> do
  <% attributes.each do |attribute| -%>
  <% if attribute.type == :references %>
  <%= attribute.name %>
  <% elsif attribute.type == :date %>
  <%= attribute.name %> Date.today
  <% elsif attribute.type == :integer %>
  sequence(:<%= attribute.name %>) { |i| i }
  <% else %>
  sequence(:<%= attribute.name %>) { |i| "<%= attribute.name %> #{i}" }
  <% end %>
  <% end %>
end
end
