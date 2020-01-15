# frozen_string_literal: true

require "rails_helper"

RSpec.describe "<%= controller_file_path %>/new", type: :view do
  before(:each) do
    assign(:<%= class_name.gsub('::','').underscore %>, attributes_for(:<%= singular_name %>))
  end

  it "renders new <%= class_name.gsub('::','').underscore %> form" do
    render

    assert_select "form[action=?][method=?]", <%= controller_name.gsub('::','').underscore %>_path, "post" do
    <% attributes.each do |attribute| -%>
    <% if attribute.type == :references %>
    assert_select "select[name=?]", "<%= class_name.gsub('::','').underscore %>[<%= attribute.name %>]"
    <% else %>
    assert_select "input[name=?]", "<%= class_name.gsub('::','').underscore %>[<%= attribute.name %>]"
    <% end %>
    <% end %>

    end
  end
end
