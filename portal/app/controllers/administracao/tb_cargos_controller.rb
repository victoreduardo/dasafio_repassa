class Administracao::TbCargosController < Administracao::ApplicationController
  before_action :set_tb_cargo, only: [:show, :edit, :update, :destroy]
  before_action :add_breadcrumb_modulo

  # GET /tb_cargos
  def index
    @q = TbCargo.ransack(params[:q])
    @tb_cargos = @q.result
  end

  # GET /tb_cargos/1
  def show
    add_breadcrumb label_translate(:show)
  end

  # GET /tb_cargos/new
  def new
    add_breadcrumb label_translate(:new)
    @tb_cargo = TbCargo.new
  end

  # GET /tb_cargos/1/edit
  def edit
    add_breadcrumb label_translate(:edit)
  end

  # POST /tb_cargos
  def create
    @tb_cargo = TbCargo.new(tb_cargo_params)

    if @tb_cargo.save
      redirect_to administracao_tb_cargo_path(@tb_cargo), notice: flash_messages_translate(:successfully_created)
    else
      render action: "new"
    end
  end

  # PATCH/PUT /tb_cargos/1
  def update
    if @tb_cargo.update(tb_cargo_params)
      redirect_to administracao_tb_cargo_path(@tb_cargo), notice: flash_messages_translate(:successfully_updated)
    else
      render action: "edit"
    end
  end

  # DELETE /tb_cargos/1
  def destroy
    if @tb_cargo.destroy
      flash[:notice] = flash_messages_translate(:successfully_destroyed)
    else
      flash[:danger] = flash_messages_translate(:unsuccessfully_destroyed) + ' ' + @tb_cargo.errors.full_messages.join(', ')
    end
    redirect_to administracao_tb_cargos_path
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_tb_cargo
    @tb_cargo = TbCargo.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def tb_cargo_params
    params.require(:tb_cargo).permit(:nome, :salario)
  end

  # Adiciona Breadcrumb geral para o controller
  def add_breadcrumb_modulo
    add_breadcrumb pluralize_model(TbCargo), administracao_tb_cargos_path
  end
end
