# frozen_string_literal: true

require "rails_helper"

RSpec.describe TbAvaliacao, type: :model do
  subject { TbAvaliacao.new FactoryBot.attributes_for(:tb_avaliacao) }
    it { is_expected.to respond_to :tb_empregado_id }
    it { is_expected.to respond_to :tb_empregado_gerente_id }
    it { is_expected.to respond_to :media }
    it { is_expected.to respond_to :dta_finalizacao }
    it { is_expected.to respond_to :status }

end
