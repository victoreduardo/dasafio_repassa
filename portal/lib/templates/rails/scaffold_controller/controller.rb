<% if namespaced? -%>
require_dependency "<%= namespaced_file_path %>/application_controller"

<% end -%>
<% module_namespacing do -%>
class <%= controller_class_name %>Controller < ApplicationController
  before_action :set_<%= singular_table_name %>, only: [:show, :edit, :update, :destroy]
  before_action :add_breadcrumb_modulo
  before_action :autorizacao

  # GET <%= route_url %>
  def index
    @q = <%= class_name %>.ransack(params[:q])
    @<%= plural_table_name %> = @q.result #Caso a busca possua relacionamento, inserir @q.result.joins(:relacionamento)
  end

  # GET <%= route_url %>/1
  def show
    add_breadcrumb label_translate(:show)
  end

  # GET <%= route_url %>/new
  def new
    add_breadcrumb label_translate(:new)
    @<%= singular_table_name %> = <%= orm_class.build(class_name) %>
  end

  # GET <%= route_url %>/1/edit
  def edit
    add_breadcrumb label_translate(:edit)
  end

  # POST <%= route_url %>
  def create
    @<%= singular_table_name %> = <%= orm_class.build(class_name, "#{singular_table_name}_params") %>

    if @<%= orm_instance.save %>
      redirect_to @<%= singular_table_name %>, notice: flash_messages_translate(:successfully_created)
    else
      render action: "new"
    end
  end

  # PATCH/PUT <%= route_url %>/1
  def update
    if @<%= orm_instance.update("#{singular_table_name}_params") %>
      redirect_to @<%= singular_table_name %>, notice: flash_messages_translate(:successfully_updated)
    else
      render action: "edit"
    end
  end

  # DELETE <%= route_url %>/1
  def destroy
  if @<%= orm_instance.destroy %>
    flash[:notice] = flash_messages_translate(:successfully_destroyed)
  else
    flash[:danger] = flash_messages_translate(:unsuccessfully_destroyed) + ' ' + @<%= orm_instance.destroy %>.errors.full_messages.join(', ')
  end
    redirect_to <%= index_helper %>_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_<%= singular_table_name %>
      @<%= singular_table_name %> = <%= orm_class.find(class_name, "params[:id]") %>
    end

    # Only allow a trusted parameter "white list" through.
    def <%= "#{singular_table_name}_params" %>
  <%- if attributes_names.empty? -%>
      params[<%= ":#{singular_table_name}" %>]
      <%- else -%>
      params.require(<%= ":#{singular_table_name}" %>).permit(<%= attributes_names.map { |name| ":#{name}" }.join(', ') %>)
      <%- end -%>
    end

    # Verifica se o usuario possui permissao para acessar o controller
    def autorizacao
      #authorize! :manage, :
    end

    # Adiciona Breadcrumb geral para o controller
    def add_breadcrumb_modulo
      add_breadcrumb pluralize_model(<%= class_name %>), <%= singular_table_name %>s_path
    end
end
<% end -%>
