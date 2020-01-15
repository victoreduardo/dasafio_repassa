# frozen_string_literal: true

FactoryBot.define do
  factory :tb_empregado, class: TbEmpregado do
    sequence(:nome) { |i| "Colaborador #{i}" }

    nmr_cpf { CPF.generate }

    sequence(:end_email) { |i| "email#{i}@admin.com" }

    dta_nascimento { Date.today }

    sexo { :masculino }

    dta_admissao { Date.today }

    tb_cargo_id { FactoryBot.create(:tb_cargo).id }
  end

  factory :tb_empregado_gerente, parent: :tb_empregado do
    tb_cargo_id { FactoryBot.create(:tb_cargo_gerente).id }
  end
end
