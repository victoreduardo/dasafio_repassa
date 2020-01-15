# frozen_string_literal: true

class TbEmpregado < ActiveRecord::Base
  # main config ...............................................................
  audited
  require "cpf_cnpj"
  # extends ...................................................................
  # includes ..................................................................
  # security (i.e. attr_accessible) ...........................................
  attr_accessor :e_admin
  # relationships .............................................................
  belongs_to :tb_cargo
  has_one :user, dependent: :delete

  # validations ...............................................................
  validates_presence_of :nome, :nmr_cpf, :end_email, :dta_nascimento, :sexo, :dta_admissao, :tb_cargo_id
  validate :valid_nmr_cpf,
           if: ->(x) { x.nmr_cpf.present? && !CPF.valid?(x.nmr_cpf) }
  validates :end_email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates_uniqueness_of :end_email, :nmr_cpf

  # callbacks .................................................................
  after_create :cria_user
  # scopes ....................................................................
  scope :filtrar_por_gerentes, -> { where(tb_cargo_id: TbCargo.find_by(chave: :gerente)&.id) }
  scope :filtrar_por_nome, ->(value) { where("upper(nome) like upper('%#{value}%')") if value.present? }
  scope :filtrar_por_cargo, ->(value) { where(tb_cargo_id: TbCargo.find_by(chave: value)&.id) if value.present? }
  # additional config .........................................................
  enum sexo: {
      masculino: 1,
      feminino: 2
  }
  # class methods .............................................................
  # public instance methods ...................................................

  def cria_user
    return if user.present?
    User.create(email: self.end_email, password: '123123', password_confirmation: '123123',
                tb_empregado_id: self.id, e_admin: self.e_admin || false).encrypted_password
  end
  # protected instance methods ................................................
  # private instance methods ..................................................

  private
  def valid_nmr_cpf
    self.errors.add(:nmr_cpf, 'inválido!')
  end
end
