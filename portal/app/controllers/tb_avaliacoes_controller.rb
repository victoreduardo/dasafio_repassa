class TbAvaliacoesController < ApplicationController
  before_action :set_tb_avaliacao, only: :show
  before_action :add_breadcrumb_modulo

  # GET administracao/tb_avaliacoes
  def index
    @q = TbAvaliacao.ransack(params[:q])
    @tb_avaliacoes = @q.result.includes(:tb_empregado_gerente, :tb_empregado).where(tb_empregado_id: current_user.tb_empregado&.id)
  end

  # GET administracao/tb_avaliacoes/1
  def show
    add_breadcrumb label_translate(:show)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_tb_avaliacao
    @tb_avaliacao = TbAvaliacao.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def tb_avaliacao_params
    params.require(:tb_avaliacao).permit(:tb_empregado_id, :tb_empregado_gerente_id, :media, :dta_finalizacao)
  end

  # Adiciona Breadcrumb geral para o controller
  def add_breadcrumb_modulo
    add_breadcrumb breadcrumb('usuario.avaliacoes.base'), administracao_tb_avaliacoes_path
  end
end
