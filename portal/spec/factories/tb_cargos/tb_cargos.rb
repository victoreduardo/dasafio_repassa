# frozen_string_literal: true

FactoryBot.define do
  factory :tb_cargo, class: TbCargo do
    sequence(:nome) { |i| "Cargo #{i}" }
    salario { Faker::Number.between(from: 8000, to: 11000) }
  end

  factory :tb_cargo_gerente, class: TbCargo do
    nome { 'Gerente' }
    salario { Faker::Number.between(from: 13000, to: 15000) }
  end
end
