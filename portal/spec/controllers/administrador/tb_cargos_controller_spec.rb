# frozen_string_literal: true

require "rails_helper"

RSpec.describe Administracao::TbCargosController, type: :controller do
  login_admin
  let(:correct_breadcrumbs) { [controller.breadcrumb('administracao.base'), controller.pluralize_model(TbCargo)] }

  describe "GET #index" do
    let(:tb_cargos) { FactoryBot.create_list(:tb_cargo, 2) }

    before { get :index }

    it "renderiza um success response" do
      expect(response).to be_successful
    end

    it "renderiza index view" do
      expect(response).to render_template :index
    end

    it "popula uma variável tb_cargos" do
      expect(assigns(:tb_cargos)).to eq(tb_cargos)
    end

    it "possui o correto breadcrumbs" do
      expect(assigns(:breadcrumbs).map { |b| b.first }).to eq(correct_breadcrumbs)
    end
  end

  describe "GET #show" do
    let(:show_breadcrumbs) { correct_breadcrumbs << controller.label_translate(:show) }

    let(:tb_cargo) { FactoryBot.create(:tb_cargo) }

    before { get :show, params: { id: tb_cargo.id } }

    it "renderiza um success response" do
      expect(response).to be_successful
    end

    it "renderiza show view" do
      expect(response).to render_template :show
    end

    it "popula uma variável @tb_cargo" do
      expect(assigns(:tb_cargo)).to eq(tb_cargo)
    end

    it "instancia uma variável de TbCargo" do
      expect(assigns(:tb_cargo)).to be_a(TbCargo)
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

    it "instancia uma nova variável @tb_cargo com TbCargo" do
      expect(assigns(:tb_cargo)).to be_a_new(TbCargo)
    end
  end

  describe "GET #edit" do
    let(:edit_breadcrumbs) { correct_breadcrumbs << controller.label_translate(:edit) }

    let(:tb_cargo) { FactoryBot.create(:tb_cargo) }

    before { get :edit, params: { id: tb_cargo.id } }

    it "renderiza um success response" do
      expect(response).to be_successful
    end

    it "renderiza edit view" do
      expect(response).to render_template :edit
    end

    it "possui o correto breadcrumbs" do
      expect(assigns(:breadcrumbs).map { |b| b.first }).to eq(edit_breadcrumbs)
    end

    it "instancia uma variável @tb_cargo com um objeto de TbCargo" do
      expect(assigns(:tb_cargo)).to eq(tb_cargo)
    end

    it "instancia uma variável de TbCargo" do
      expect(assigns(:tb_cargo)).to be_a(TbCargo)
    end
  end

  describe "POST #create" do
    before { post :create, params: { tb_cargo: tb_cargos_attributes } }

    context "com parametros válidos" do
      let(:tb_cargos_attributes) { FactoryBot.attributes_for(:tb_cargo) }

      it "verifica a persistencia da variável @tb_cargo" do
        expect(assigns(:tb_cargo)).to be_persisted
      end

      it "instancia uma variável de TbCargo" do
        expect(assigns(:tb_cargo)).to be_a(TbCargo)
      end

      it "salva o tb_cargo correto" do
        expect(assigns(:tb_cargo)).to eq(TbCargo.last)
      end
    end

    context "com parametros inválidos" do
      let(:tb_cargos_attributes) { FactoryBot.attributes_for(:tb_cargo, atributo_not_null: nil) }

      it "instancia uma variável de TbCargo" do
        expect(assigns(:tb_cargo)).to be_a(TbCargo)
      end

      it "não cria um novo TbCargo" do
        expect(assigns(:tb_cargo)).not_to be_persisted
      end

      it "renderiza a view #new" do
        expect(response).to render_template :new
      end
    end
  end

  describe "PUT #update" do
    before { put :update, params: { id: tb_cargo.id, tb_cargo: tb_cargos_attributes } }

    context "com parametros válidos" do
      let(:tb_cargo) { FactoryBot.create(:tb_cargo) }
      let(:tb_cargos_attributes) { FactoryBot.attributes_for(:tb_cargo) } #, atributo: "Foo Bar") }

      it "instancia uma variável de TbCargo" do
        expect(assigns(:tb_cargo)).to be_a(TbCargo)
      end

      it "redireciona para #show" do
        expect(response).to redirect_to(administracao_tb_cargo_path(TbCargo.last))
      end
    end

    context "com parametros inválidos" do
      let(:tb_cargo) { FactoryBot.create(:tb_cargo) }
      let(:tb_cargos_attributes) { FactoryBot.attributes_for(:tb_cargo, atributo_not_null: nil) }

      it "instancia uma variável de TbCargo" do
        expect(assigns(:tb_cargo)).to be_a(TbCargo)
      end

      it "renderiza a view #edit" do
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "DELETE #destroy" do
    let(:tb_cargo) { FactoryBot.create(:tb_cargo) }

    before { delete :destroy, params: { id: tb_cargo.id } }

    it "instancia uma variável de TbCargo" do
      expect(assigns(:tb_cargo)).to be_a(TbCargo)
    end

    it "remove o tb_cargo" do
      expect(TbCargo.count).to eq(0)
    end

    it "redireciona para #index" do
      expect(response).to redirect_to(administracao_tb_cargos_path)
    end
  end
end
