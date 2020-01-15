module ControllerMacros
  def login_admin
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      sign_in FactoryBot.create(:admin)
    end
  end

  def login_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = FactoryBot.create(:user)
      sign_in user
    end
  end

  def login_gerente
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = FactoryBot.create(:user)
      sign_in user
      cargo = FactoryBot.create(:tb_cargo_gerente)
      if user.tb_empregado
        user.tb_empregado.update_column(:tb_cargo_id, cargo.id)
      else
        empregado = FactoryBot.create(:tb_empregado, { tb_cargo_id: cargo.id })
        user.update_column(:tb_empregado_id, empregado.id)
      end
    end
  end
end
