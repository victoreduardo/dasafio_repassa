class Administracao::TbPerguntasController < Administracao::ApplicationController
  before_action :set_tb_pergunta, only: [:show, :edit, :update, :destroy]
  before_action :add_breadcrumb_modulo

  # GET /tb_perguntas
  def index
    @q = TbPergunta.ransack(params[:q])
    @tb_perguntas = @q.result
  end

  # GET /tb_perguntas/1
  def show
    add_breadcrumb label_translate(:show)
  end

  # GET /tb_perguntas/new
  def new
    add_breadcrumb label_translate(:new)
    @tb_pergunta = TbPergunta.new
  end

  # GET /tb_perguntas/1/edit
  def edit
    add_breadcrumb label_translate(:edit)
  end

  # POST /tb_perguntas
  def create
    @tb_pergunta = TbPergunta.new(tb_pergunta_params)

    if @tb_pergunta.save
      redirect_to administracao_tb_pergunta_path(@tb_pergunta), notice: flash_messages_translate(:successfully_created)
    else
      render action: "new"
    end
  end

  # PATCH/PUT /tb_perguntas/1
  def update
    if @tb_pergunta.update(tb_pergunta_params)
      redirect_to administracao_tb_pergunta_path(@tb_pergunta), notice: flash_messages_translate(:successfully_updated)
    else
      render action: "edit"
    end
  end

  # DELETE /tb_perguntas/1
  def destroy
    if @tb_pergunta.destroy
      flash[:notice] = flash_messages_translate(:successfully_destroyed)
    else
      flash[:danger] = flash_messages_translate(:unsuccessfully_destroyed) + ' ' + @tb_pergunta.errors.full_messages.join(', ')
    end
    redirect_to administracao_tb_perguntas_path
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_tb_pergunta
    @tb_pergunta = TbPergunta.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def tb_pergunta_params
    params.require(:tb_pergunta).permit(:nme_pergunta, :descricao, :peso)
  end

  # Adiciona Breadcrumb geral para o controller
  def add_breadcrumb_modulo
    add_breadcrumb breadcrumb('administracao.avaliacao.base')
    add_breadcrumb pluralize_model(TbPergunta), administracao_tb_perguntas_path
  end
end
