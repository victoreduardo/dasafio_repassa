# frozen_string_literal: true

require "rails_helper"

RSpec.describe TbResposta, type: :model do
  subject { TbResposta.new FactoryBot.attributes_for(:tb_resposta) }
    it { is_expected.to respond_to :tb_avaliacao_id }
    it { is_expected.to respond_to :tb_pergunta_id }
    it { is_expected.to respond_to :nota }
    it { is_expected.to respond_to :obs }

end
