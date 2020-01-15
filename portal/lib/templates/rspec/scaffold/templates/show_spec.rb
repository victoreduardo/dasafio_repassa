# frozen_string_literal: true

require "rails_helper"

RSpec.describe "<%= controller_file_path %>/show", type: :view do
  before(:each) do
    @<%= class_name.gsub('::','').underscore %> = assign(:<%= class_name.gsub('::','').underscore %>, create(:<%= singular_name%>))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/<%= attributes.to_a.select {|x| x.type == :string }.first.name %>/)
  end
end
