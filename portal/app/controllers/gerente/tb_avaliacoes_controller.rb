class Gerente::TbAvaliacoesController < Gerente::ApplicationController
  before_action :set_tb_avaliacao, only: [:edit, :update]
  before_action :add_breadcrumb_modulo

  # GET gerente/tb_avaliacoes
  def index
    @q = TbAvaliacao.ransack(params[:q])
    @tb_avaliacoes = @q.result.includes(:tb_empregado_gerente, :tb_empregado)
                         .filtrar_por_gerente(current_user.id)
  end

  # GET gerente/tb_avaliacoes/1
  def show
    add_breadcrumb label_translate(:show)
    @tb_avaliacao = TbAvaliacao.includes(:tb_respostas, :tb_empregado, :tb_empregado_gerente).find(params[:id])
  end

  # GET gerente/tb_avaliacoes/1/edit
  def edit
    add_breadcrumb label_translate(:edit)
    TbPergunta.all.each do |pergunta|
      @tb_avaliacao.tb_respostas.build(tb_pergunta_id: pergunta.id,
                                       nme_pergunta: pergunta.nme_pergunta,
                                       descricao_pergunta: pergunta.descricao)
    end
  end

  # PATCH/PUT gerente/tb_avaliacoes/1
  def update
    if @tb_avaliacao.update(tb_avaliacao_params.merge(dta_finalizacao: DateTime.now,
                                                      status: :finalizado))
      @tb_avaliacao.calcular_media
      redirect_to gerente_tb_avaliacao_path(@tb_avaliacao), notice: flash_messages_translate(:successfully_updated)
    else
      render action: 'edit'
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_tb_avaliacao
    @tb_avaliacao = TbAvaliacao.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def tb_avaliacao_params
    params.require(:tb_avaliacao).permit(:id,
                                         tb_respostas_attributes: %i(id tb_pergunta_id nota obs))
  end

  # Adiciona Breadcrumb geral para o controller
  def add_breadcrumb_modulo
    add_breadcrumb pluralize_model(TbAvaliacao), gerente_tb_avaliacoes_path
  end
end
