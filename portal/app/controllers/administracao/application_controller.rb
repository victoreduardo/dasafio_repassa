class Administracao::ApplicationController < ApplicationController
  before_action :verifica_permissao_adm, except: :autocomplete
  before_action :add_breadcrumb_administracao

  private
  def add_breadcrumb_administracao
    add_breadcrumb breadcrumb('administracao.base')
  end

  def verifica_permissao_adm
    unless current_user.e_admin?
      flash[:danger] = specific_alert(:permission_denied)
      redirect_to root_path
    end
  end

end
