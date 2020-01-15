class Administracao::TbEmpregadosController < Administracao::ApplicationController
  before_action :set_tb_empregado, only: [:show, :edit, :update, :destroy]
  before_action :carregar_dependencias, only: %i(new edit)
  before_action :add_breadcrumb_modulo

  # GET /tb_empregados
  def index
    @q = TbEmpregado.ransack(params[:q])
    @tb_empregados = @q.result.includes(:tb_cargo)
  end

  # GET /tb_empregados/1
  def show
    add_breadcrumb label_translate(:show)
  end

  # GET /tb_empregados/autocomplete
  def autocomplete
    if params[:id]
      item = TbEmpregado
                 .where(id: params[:id])
                 .select('nome as text, id')
                 .first
    else
      item = TbEmpregado
                 .filtrar_por_nome(params[:q])
                 .filtrar_por_cargo(params[:chave])
                 .select('nome as text, id')
                 .order(:nome)
                 .limit(10)
    end
    render json: item
  end

  # GET /tb_empregados/new
  def new
    add_breadcrumb label_translate(:new)
    @tb_empregado = TbEmpregado.new
  end

  # GET /tb_empregados/1/edit
  def edit
    add_breadcrumb label_translate(:edit)
  end

  # POST /tb_empregados
  def create
    @tb_empregado = TbEmpregado.new(tb_empregado_params)

    if @tb_empregado.save
      redirect_to administracao_tb_empregado_path(@tb_empregado), notice: flash_messages_translate(:successfully_created)
    else
      carregar_dependencias
      render action: "new"
    end
  end

  # PATCH/PUT /tb_empregados/1
  def update
    if @tb_empregado.update(tb_empregado_params)
      redirect_to administracao_tb_empregado_path(@tb_empregado), notice: flash_messages_translate(:successfully_updated)
    else
      carregar_dependencias
      render action: "edit"
    end
  end

  # DELETE /tb_empregados/1
  def destroy
    if @tb_empregado.destroy
      flash[:notice] = flash_messages_translate(:successfully_destroyed)
    else
      flash[:danger] = flash_messages_translate(:unsuccessfully_destroyed) + ' ' + @tb_empregado.errors.full_messages.join(', ')
    end
    redirect_to administracao_tb_empregados_path
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_tb_empregado
    @tb_empregado = TbEmpregado.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def tb_empregado_params
    params.require(:tb_empregado).permit(:nome, :nmr_cpf, :end_email, :dta_nascimento, :sexo, :dta_admissao,
                                         :tb_cargo_id)
  end

  def carregar_dependencias
    @lista_tb_cargos = TbCargo.all.order(:nome)
  end

  # Adiciona Breadcrumb geral para o controller
  def add_breadcrumb_modulo
    add_breadcrumb pluralize_model(TbEmpregado), administracao_tb_empregados_path
  end
end
