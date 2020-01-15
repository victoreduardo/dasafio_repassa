# frozen_string_literal: true

require "rails_helper"

RSpec.describe "<%= controller_file_path %>/index", type: :view do
  before(:each) do
    allow(view).to receive(:can?).and_return(true)
    assign(:<%= controller_name.gsub('::','').underscore %>, create_list(:<%= singular_name %>, 2))
    @q = <%= class_name %>.ransack(params[:q])
  end

  it "renders a list of <%= controller_file_path %>" do
    render
    assert_select "tbody tr", text: /<%= attributes.to_a.select {|x| x.type == :string }.first&.name %>/, count: 2
  end
end
