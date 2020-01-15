# frozen_string_literal: true

require "rails_helper"

RSpec.describe TbCargo, type: :model do
  subject { TbCargo.new FactoryBot.attributes_for(:tb_cargo) }
    it { is_expected.to respond_to :nome }
    it { is_expected.to respond_to :salario }

end
