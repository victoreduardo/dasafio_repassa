require 'rails_helper'

RSpec.describe PrincipalController, type: :controller do
  login_user

  it 'responds successfully' do
    get :index
    expect(response).to have_http_status(:successful)
  end

end
