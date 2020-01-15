class Gerente::ApplicationController < ApplicationController
  before_action :verifica_permissao_gerente
  before_action :add_breadcrumb_gerente

  private
  def add_breadcrumb_gerente
    add_breadcrumb breadcrumb('gerente.base')
  end

  def verifica_permissao_gerente
    unless current_user.e_gerente?
      flash[:danger] = specific_alert(:permission_denied)
      redirect_to root_path
    end
  end
end
