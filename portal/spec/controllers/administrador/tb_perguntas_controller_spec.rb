# frozen_string_literal: true

require "rails_helper"

RSpec.describe Administracao::TbPerguntasController, type: :controller do
  login_admin
  let(:correct_breadcrumbs) { [controller.breadcrumb('administracao.base'),
                               controller.breadcrumb('administracao.avaliacao.base'),
                               controller.pluralize_model(TbPergunta)] }

  describe "GET #index" do
    let(:tb_perguntas) { FactoryBot.create_list(:tb_pergunta, 2) }

    before { get :index }

    it "renderiza um success response" do
      expect(response).to be_successful
    end

    it "renderiza index view" do
      expect(response).to render_template :index
    end

    it "popula uma variável tb_perguntas" do
      expect(assigns(:tb_perguntas)).to eq(tb_perguntas)
    end

    it "possui o correto breadcrumbs" do
      expect(assigns(:breadcrumbs).map { |b| b.first }).to eq(correct_breadcrumbs)
    end
  end

  describe "GET #show" do
    let(:show_breadcrumbs) { correct_breadcrumbs << controller.label_translate(:show) }

    let(:tb_pergunta) { FactoryBot.create(:tb_pergunta) }

    before { get :show, params: { id: tb_pergunta.id } }

    it "renderiza um success response" do
      expect(response).to be_successful
    end

    it "renderiza show view" do
      expect(response).to render_template :show
    end

    it "popula uma variável @tb_pergunta" do
      expect(assigns(:tb_pergunta)).to eq(tb_pergunta)
    end

    it "instancia uma variável de TbPergunta" do
      expect(assigns(:tb_pergunta)).to be_a(TbPergunta)
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

    it "instancia uma nova variável @tb_pergunta com TbPergunta" do
      expect(assigns(:tb_pergunta)).to be_a_new(TbPergunta)
    end
  end

  describe "GET #edit" do
    let(:edit_breadcrumbs) { correct_breadcrumbs << controller.label_translate(:edit) }

    let(:tb_pergunta) { FactoryBot.create(:tb_pergunta) }

    before { get :edit, params: { id: tb_pergunta.id } }

    it "renderiza um success response" do
      expect(response).to be_successful
    end

    it "renderiza edit view" do
      expect(response).to render_template :edit
    end

    it "possui o correto breadcrumbs" do
      expect(assigns(:breadcrumbs).map { |b| b.first }).to eq(edit_breadcrumbs)
    end

    it "instancia uma variável @tb_pergunta com um objeto de TbPergunta" do
      expect(assigns(:tb_pergunta)).to eq(tb_pergunta)
    end

    it "instancia uma variável de TbPergunta" do
      expect(assigns(:tb_pergunta)).to be_a(TbPergunta)
    end
  end

  describe "POST #create" do
    before { post :create, params: { tb_pergunta: tb_perguntas_attributes } }

    context "com parametros válidos" do
      let(:tb_perguntas_attributes) { FactoryBot.attributes_for(:tb_pergunta) }

      it "verifica a persistencia da variável @tb_pergunta" do
        expect(assigns(:tb_pergunta)).to be_persisted
      end

      it "instancia uma variável de TbPergunta" do
        expect(assigns(:tb_pergunta)).to be_a(TbPergunta)
      end

      it "salva o tb_pergunta correto" do
        expect(assigns(:tb_pergunta)).to eq(TbPergunta.last)
      end

      it "redireciona para #show" do
        expect(response).to redirect_to(administracao_tb_pergunta_path(TbPergunta.last))
      end
    end

    context "com parametros inválidos" do
      let(:tb_perguntas_attributes) { FactoryBot.attributes_for(:tb_pergunta, atributo_not_null: nil) }

      it "instancia uma variável de TbPergunta" do
        expect(assigns(:tb_pergunta)).to be_a(TbPergunta)
      end

      it "não cria um novo TbPergunta" do
        expect(assigns(:tb_pergunta)).not_to be_persisted
      end

      it "renderiza a view #new" do
        expect(response).to render_template :new
      end
    end
  end

  describe "PUT #update" do
    before { put :update, params: { id: tb_pergunta.id, tb_pergunta: tb_perguntas_attributes } }

    context "com parametros válidos" do
      let(:tb_pergunta) { FactoryBot.create(:tb_pergunta) }
      let(:tb_perguntas_attributes) { FactoryBot.attributes_for(:tb_pergunta) } #, atributo: "Foo Bar") }

      it "instancia uma variável de TbPergunta" do
        expect(assigns(:tb_pergunta)).to be_a(TbPergunta)
      end

      it "redireciona para #show" do
        expect(response).to redirect_to(administracao_tb_pergunta_path(TbPergunta.last))
      end
    end

    context "com parametros inválidos" do
      let(:tb_pergunta) { FactoryBot.create(:tb_pergunta) }
      let(:tb_perguntas_attributes) { FactoryBot.attributes_for(:tb_pergunta, atributo_not_null: nil) }

      it "instancia uma variável de TbPergunta" do
        expect(assigns(:tb_pergunta)).to be_a(TbPergunta)
      end

      it "renderiza a view #edit" do
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "DELETE #destroy" do
    let(:tb_pergunta) { FactoryBot.create(:tb_pergunta) }

    before { delete :destroy, params: { id: tb_pergunta.id } }

    it "instancia uma variável de TbPergunta" do
      expect(assigns(:tb_pergunta)).to be_a(TbPergunta)
    end

    it "remove o tb_pergunta" do
      expect(TbPergunta.count).to eq(0)
    end

    it "redireciona para #index" do
      expect(response).to redirect_to(administracao_tb_perguntas_path)
    end
  end
end
