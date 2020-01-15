# frozen_string_literal: true

FactoryBot.define do
  factory :tb_pergunta, class: TbPergunta do

    sequence(:nme_pergunta) { |i| "nme_pergunta #{i}" }

    sequence(:descricao) { |i| "descricao #{i}" }

    peso { Faker::Number.between(from: 1, to: 5) }

  end
end
