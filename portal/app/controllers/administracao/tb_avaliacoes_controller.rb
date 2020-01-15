class Administracao::TbAvaliacoesController < Administracao::ApplicationController
  before_action :set_tb_avaliacao, only: [:show, :edit, :update, :destroy]
  before_action :add_breadcrumb_modulo

  # GET administracao/tb_avaliacoes
  def index
    @q = TbAvaliacao.ransack(params[:q])
    @tb_avaliacoes = @q.result.includes(:tb_empregado_gerente, :tb_empregado)
  end

  # GET administracao/tb_avaliacoes/1
  def show
    add_breadcrumb label_translate(:show)
  end

  # GET administracao/tb_avaliacoes/new
  def new
    add_breadcrumb label_translate(:new)
    @tb_avaliacao = TbAvaliacao.new
  end

  # GET administracao/tb_avaliacoes/1/edit
  def edit
    add_breadcrumb label_translate(:edit)
  end

  # POST administracao/tb_avaliacoes
  def create
    @tb_avaliacao = TbAvaliacao.new(tb_avaliacao_params)

    if @tb_avaliacao.save
      redirect_to administracao_tb_avaliacao_path(@tb_avaliacao), notice: flash_messages_translate(:successfully_created)
    else
      render action: "new"
    end
  end

  # PATCH/PUT administracao/tb_avaliacoes/1
  def update
    if @tb_avaliacao.update(tb_avaliacao_params)
      redirect_to administracao_tb_avaliacao_path(@tb_avaliacao), notice: flash_messages_translate(:successfully_updated)
    else
      render action: "edit"
    end
  end

  # DELETE administracao/tb_avaliacoes/1
  def destroy
    if @tb_avaliacao.destroy
      flash[:notice] = flash_messages_translate(:successfully_destroyed)
    else
      flash[:danger] = flash_messages_translate(:unsuccessfully_destroyed) + ' ' + @tb_avaliacao.destroy.errors.full_messages.join(', ')
    end
    redirect_to administracao_tb_avaliacoes_path
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
    add_breadcrumb pluralize_model(TbAvaliacao), administracao_tb_avaliacoes_path
  end
end
