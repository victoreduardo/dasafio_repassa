# frozen_string_literal: true

require "rails_helper"

RSpec.describe <%= class_name %>, type: :model do
  subject { <%= class_name %>.new attributes_for(:<%= singular_name %>) }
  <% attributes.each do |attribute| -%>
  it { is_expected.to respond_to :<%= attribute.name %> }
  <% end %>
end