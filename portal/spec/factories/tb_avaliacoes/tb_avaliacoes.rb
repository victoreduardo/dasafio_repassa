# frozen_string_literal: true

FactoryBot.define do
  factory :tb_avaliacao, class: TbAvaliacao do
    tb_empregado_id { FactoryBot.create(:tb_empregado).id }
    tb_empregado_gerente_id { FactoryBot.create(:tb_empregado).id }
    media { 0 }
    status { :aguardando }
    dta_finalizacao { nil }
    trait :tb_respostas_attributes do
      tb_respostas_attributes { FactoryBot.create(:tb_resposta, { tb_pergunta_id: FactoryBot.create(:tb_pergunta),
                                                                  nota: :medio }) }
    end
  end
end
