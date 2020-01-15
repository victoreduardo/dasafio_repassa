# frozen_string_literal: true

require "rails_helper"
require 'spec_helper'

RSpec.describe Administracao::TbAvaliacoesController, type: :controller do
  login_admin
  let(:correct_breadcrumbs) { [controller.breadcrumb('administracao.base'), controller.pluralize_model(TbAvaliacao)] }

  describe "GET #index" do
    let(:tb_avaliacoes) { FactoryBot.create_list(:tb_avaliacao, 2) }

    before { get :index }

    it "renderiza um success response" do
      expect(response).to be_successful
    end

    it "renderiza index view" do
      expect(response).to render_template :index
    end

    it "possui o correto breadcrumbs" do
      expect(assigns(:breadcrumbs).map { |b| b.first }).to eq(correct_breadcrumbs)
    end
  end

  describe "GET #show" do
    let(:show_breadcrumbs) { correct_breadcrumbs << controller.label_translate(:show) }

    let(:tb_avaliacao) { FactoryBot.create(:tb_avaliacao) }

    before { get :show, params: { id: tb_avaliacao.id } }

    it "renderiza um success response" do
      expect(response).to be_successful
    end

    it "renderiza show view" do
      expect(response).to render_template :show
    end

    it "popula uma variável @tb_avaliacao" do
      expect(assigns(:tb_avaliacao)).to eq(tb_avaliacao)
    end

    it "instancia uma variável de TbAvaliacao" do
      expect(assigns(:tb_avaliacao)).to be_a(TbAvaliacao)
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

    it "instancia uma nova variável @tb_avaliacao com TbAvaliacao" do
      expect(assigns(:tb_avaliacao)).to be_a_new(TbAvaliacao)
    end
  end

  describe "GET #edit" do
    let(:edit_breadcrumbs) { correct_breadcrumbs << controller.label_translate(:edit) }

    let(:tb_avaliacao) { FactoryBot.create(:tb_avaliacao) }

    before { get :edit, params: { id: tb_avaliacao.id } }

    it "renderiza um success response" do
      expect(response).to be_successful
    end

    it "renderiza edit view" do
      expect(response).to render_template :edit
    end

    it "possui o correto breadcrumbs" do
      expect(assigns(:breadcrumbs).map { |b| b.first }).to eq(edit_breadcrumbs)
    end

    it "instancia uma variável @tb_avaliacao com um objeto de TbAvaliacao" do
      expect(assigns(:tb_avaliacao)).to eq(tb_avaliacao)
    end

    it "instancia uma variável de TbAvaliacao" do
      expect(assigns(:tb_avaliacao)).to be_a(TbAvaliacao)
    end
  end

  describe "POST #create" do
    before { post :create, params: { tb_avaliacao: tb_avaliacoes_attributes } }

    context "com parametros válidos" do
      let(:tb_avaliacoes_attributes) { FactoryBot.attributes_for(:tb_avaliacao) }

      it "verifica a persistencia da variável @tb_avaliacao" do
        expect(assigns(:tb_avaliacao)).to be_persisted
      end

      it "instancia uma variável de TbAvaliacao" do
        expect(assigns(:tb_avaliacao)).to be_a(TbAvaliacao)
      end

      it "salva o tb_avaliacao correto" do
        expect(assigns(:tb_avaliacao)).to eq(TbAvaliacao.last)
      end

      it "redireciona para #show" do
        expect(response).to redirect_to(TbAvaliacao.last)
      end
    end

    context "com parametros inválidos" do
      let(:tb_avaliacoes_attributes) { FactoryBot.attributes_for(:tb_avaliacao, atributo_not_null: nil) }

      it "instancia uma variável de TbAvaliacao" do
        expect(assigns(:tb_avaliacao)).to be_a(TbAvaliacao)
      end

      it "não cria um novo TbAvaliacao" do
        expect(assigns(:tb_avaliacao)).not_to be_persisted
      end

      it "renderiza a view #new" do
        expect(response).to render_template :new
      end
    end
  end

  describe "PUT #update" do
    before { put :update, params: { id: tb_avaliacao.id, tb_avaliacao: tb_avaliacoes_attributes } }

    context "com parametros válidos" do
      let(:tb_avaliacao) { FactoryBot.create(:tb_avaliacao) }
      let(:tb_avaliacoes_attributes) { FactoryBot.attributes_for(:tb_avaliacao) } #, atributo: "Foo Bar") }

      it "instancia uma variável de TbAvaliacao" do
        expect(assigns(:tb_avaliacao)).to be_a(TbAvaliacao)
      end

      it "redireciona para #show" do
        expect(response).to redirect_to(administracao_tb_avaliacao_path(TbAvaliacao.last))
      end
    end

    context "com parametros inválidos" do
      let(:tb_avaliacao) { FactoryBot.create(:tb_avaliacao) }
      let(:tb_avaliacoes_attributes) { FactoryBot.attributes_for(:tb_avaliacao, atributo_not_null: nil) }

      it "instancia uma variável de TbAvaliacao" do
        expect(assigns(:tb_avaliacao)).to be_a(TbAvaliacao)
      end

      it "renderiza a view #edit" do
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "DELETE #destroy" do
    let(:tb_avaliacao) { FactoryBot.create(:tb_avaliacao) }

    before { delete :destroy, params: { id: tb_avaliacao.id } }

    it "instancia uma variável de TbAvaliacao" do
      expect(assigns(:tb_avaliacao)).to be_a(TbAvaliacao)
    end

    it "remove o tb_avaliacao" do
      expect(TbAvaliacao.count).to eq(0)
    end

    it "redireciona para #index" do
      expect(response).to redirect_to(tb_avaliacoes_path)
    end
  end
end
