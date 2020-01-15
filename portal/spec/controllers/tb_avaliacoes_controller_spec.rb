# frozen_string_literal: true

require "rails_helper"
require 'spec_helper'

RSpec.describe TbAvaliacoesController, type: :controller do
  login_admin
  let(:correct_breadcrumbs) { [controller.breadcrumb('usuario.avaliacoes.base')] }

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

end
