class PrincipalController < ApplicationController
  before_action :carrega_parametros, only: %i(index)

  def index
    @qtd_colaboradores = TbEmpregado.all.count
    @total_folha = TbEmpregado.includes(:tb_cargo).map { |x| x.tb_cargo.salario }.sum
    @qtd_avaliacoes_pend = TbAvaliacao.filtrar_por_status(:aguardando).count
    @qtd_avaliacoes_fina = TbAvaliacao.filtrar_por_status(:finalizado).count
  end

  private

  def carrega_parametros
  end

  def add_breadcrumb_index
    add_breadcrumb 'Principal', root_path
  end
end
