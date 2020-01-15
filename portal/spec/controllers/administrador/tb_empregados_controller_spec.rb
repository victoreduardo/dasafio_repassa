# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Administracao::TbEmpregadosController, type: :controller do
  login_admin
  let(:correct_breadcrumbs) { [controller.breadcrumb('administracao.base'), controller.pluralize_model(TbEmpregado)] }

  describe "GET #index" do
    let(:tb_empregados) { FactoryBot.create_list(:tb_empregado, 2) }

    before { get :index }

    it "renderiza um success response" do
      expect(response).to be_successful
    end

    it "renderiza index view" do
      expect(response).to render_template :index
    end

    it "popula uma variável tb_empregados" do
      expect(assigns(:tb_empregados)).to eq(tb_empregados)
    end

    it "possui o correto breadcrumbs" do
      expect(assigns(:breadcrumbs).map { |b| b.first }).to eq(correct_breadcrumbs)
    end
  end

  describe "GET #show" do
    let(:show_breadcrumbs) { correct_breadcrumbs << controller.label_translate(:show) }

    let(:tb_empregado) { FactoryBot.create(:tb_empregado) }

    before { get :show, params: { id: tb_empregado.id } }

    it "renderiza um success response" do
      expect(response).to be_successful
    end

    it "renderiza show view" do
      expect(response).to render_template :show
    end

    it "popula uma variável @tb_empregado" do
      expect(assigns(:tb_empregado)).to eq(tb_empregado)
    end

    it "instancia uma variável de TbEmpregado" do
      expect(assigns(:tb_empregado)).to be_a(TbEmpregado)
    end

    it "possui o correto breadcrumbs" do
      expect(assigns(:breadcrumbs).map { |b| b.first }).to eq(show_breadcrumbs)
    end
  end

  describe "GET #new" do
    let(:new_breadcrumbs) { correct_breadcrumbs << controller.label_translate(:new) }

    before { get :new }

    it "renderiza um success response" do
      expect(response).to be_successful
    end

    it "renderiza new view" do
      expect(response).to render_template :new
    end

    it "possui o correto breadcrumbs" do
      expect(assigns(:breadcrumbs).map { |b| b.first }).to eq(new_breadcrumbs)
    end

    it "instancia uma nova variável @tb_empregado com TbEmpregado" do
      expect(assigns(:tb_empregado)).to be_a_new(TbEmpregado)
    end
  end

  describe "GET #edit" do
    let(:edit_breadcrumbs) { correct_breadcrumbs << controller.label_translate(:edit) }

    let(:tb_empregado) { FactoryBot.create(:tb_empregado) }

    before { get :edit, params: { id: tb_empregado.id } }

    it "renderiza um success response" do
      expect(response).to be_successful
    end

    it "renderiza edit view" do
      expect(response).to render_template :edit
    end

    it "possui o correto breadcrumbs" do
      expect(assigns(:breadcrumbs).map { |b| b.first }).to eq(edit_breadcrumbs)
    end

    it "instancia uma variável @tb_empregado com um objeto de TbEmpregado" do
      expect(assigns(:tb_empregado)).to eq(tb_empregado)
    end

    it "instancia uma variável de TbEmpregado" do
      expect(assigns(:tb_empregado)).to be_a(TbEmpregado)
    end
  end

  describe "POST #create" do
    before { post :create, params: { tb_empregado: tb_empregados_attributes } }

    context "com parametros válidos" do
      let(:tb_empregados_attributes) { FactoryBot.attributes_for(:tb_empregado) }

      it "verifica a persistencia da variável @tb_empregado" do
        expect(assigns(:tb_empregado)).to be_persisted
      end

      it "instancia uma variável de TbEmpregado" do
        expect(assigns(:tb_empregado)).to be_a(TbEmpregado)
      end

      it "salva o tb_empregado correto" do
        expect(assigns(:tb_empregado)).to eq(TbEmpregado.last)
      end
    end

    context "com parametros inválidos" do
      let(:tb_empregados_attributes) { FactoryBot.attributes_for(:tb_empregado, atributo_not_null: nil) }

      it "instancia uma variável de TbEmpregado" do
        expect(assigns(:tb_empregado)).to be_a(TbEmpregado)
      end

      it "não cria um novo TbEmpregado" do
        expect(assigns(:tb_empregado)).not_to be_persisted
      end

      it "renderiza a view #new" do
        expect(response).to render_template :new
      end
    end
  end

  describe "PUT #update" do
    before { put :update, params: { id: tb_empregado.id, tb_empregado: tb_empregados_attributes } }

    context "com parametros válidos" do
      let(:tb_empregado) { FactoryBot.create(:tb_empregado) }
      let(:tb_empregados_attributes) { FactoryBot.attributes_for(:tb_empregado) } #, atributo: "Foo Bar") }

      it "instancia uma variável de TbEmpregado" do
        expect(assigns(:tb_empregado)).to be_a(TbEmpregado)
      end

      it "redireciona para #show" do
        expect(response).to redirect_to(administracao_tb_empregado_path(TbEmpregado.last))
      end
    end

    context "com parametros inválidos" do
      let(:tb_empregado) { FactoryBot.create(:tb_empregado) }
      let(:tb_empregados_attributes) { FactoryBot.attributes_for(:tb_empregado, atributo_not_null: nil) }

      it "instancia uma variável de TbEmpregado" do
        expect(assigns(:tb_empregado)).to be_a(TbEmpregado)
      end

      it "renderiza a view #edit" do
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "DELETE #destroy" do
    let(:tb_empregado) { FactoryBot.create(:tb_empregado) }

    before { delete :destroy, params: { id: tb_empregado.id } }

    it "instancia uma variável de TbEmpregado" do
      expect(assigns(:tb_empregado)).to be_a(TbEmpregado)
    end

    it "remove o tb_empregado" do
      expect(TbEmpregado.count).to eq(0)
    end

    it "redireciona para #index" do
      expect(response).to redirect_to(administracao_tb_empregados_path)
    end
  end
end
