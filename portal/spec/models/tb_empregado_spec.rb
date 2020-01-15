# frozen_string_literal: true

require "rails_helper"

RSpec.describe TbEmpregado, type: :model do
  subject { TbEmpregado.new FactoryBot.attributes_for(:tb_empregado) }
    it { is_expected.to respond_to :nome }
    it { is_expected.to respond_to :nmr_cpf }
    it { is_expected.to respond_to :end_email }
    it { is_expected.to respond_to :dta_nascimento }
    it { is_expected.to respond_to :sexo }
    it { is_expected.to respond_to :dta_admissao }
end
