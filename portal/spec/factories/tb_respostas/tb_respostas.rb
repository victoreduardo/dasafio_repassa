# frozen_string_literal: true

FactoryBot.define do
  factory :tb_resposta, class: TbResposta do
    tb_avaliacao_id { FactoryBot.create(:tb_avaliacao) }
    tb_pergunta_id { FactoryBot.create(:tb_pergunta) }
    sequence(:obs) { |i| "obs #{i}" }
    nota { :medio }
  end
end
