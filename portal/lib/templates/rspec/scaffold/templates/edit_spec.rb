# frozen_string_literal: true

require "rails_helper"

RSpec.describe "<%= controller_file_path %>/edit", type: :view do
  before(:each) do
    @<%= class_name.gsub('::','').underscore %> = assign(:<%= class_name.gsub('::','').underscore %>, create(:<%= singular_name%>))
  end

  it "renders the edit <%= class_name.gsub('::','').underscore %> form" do
    render

    assert_select "form[action=?][method=?]", <%= class_name.gsub('::','').underscore %>_path(@<%= class_name.gsub('::','').underscore %>), "post" do
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
