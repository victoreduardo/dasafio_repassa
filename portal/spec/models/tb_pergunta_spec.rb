# frozen_string_literal: true

require "rails_helper"

RSpec.describe TbPergunta, type: :model do
  subject { TbPergunta.new FactoryBot.attributes_for(:tb_pergunta) }
    it { is_expected.to respond_to :nme_pergunta }
    it { is_expected.to respond_to :descricao }
    it { is_expected.to respond_to :peso }

end
