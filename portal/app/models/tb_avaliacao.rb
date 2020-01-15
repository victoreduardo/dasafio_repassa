# frozen_string_literal: true

class TbAvaliacao < ActiveRecord::Base
  # main config ...............................................................
  audited
  # extends ...................................................................
  # includes ..................................................................
  # security (i.e. attr_accessible) ...........................................
  # relationships .............................................................
  belongs_to :tb_empregado
  belongs_to :tb_empregado_gerente, class_name: 'TbEmpregado', foreign_key: :tb_empregado_gerente_id

  has_many :tb_respostas, dependent: :delete_all
  accepts_nested_attributes_for :tb_respostas

  # validations ...............................................................
  validates_presence_of :tb_empregado_id, :tb_empregado_gerente_id
  validate :verificar_empregados_iguais,
           if: ->(x) { x.tb_empregado_gerente_id == tb_empregado_id }

  # callbacks .................................................................
  # scopes ....................................................................
  scope :filtrar_por_gerente,
        ->(value) { joins(:tb_empregado_gerente).where(tb_empregado_gerente_id: value) if value.present? }
  scope :filtrar_por_status, ->(value) { where(status: value) if value }

  # additional config .........................................................
  enum status: {
      aguardando: 1,
      finalizado: 2
  }
  # class methods .............................................................
  # public instance methods ...................................................

  # Método que verifica se o status é aguardando
  #
  # @return[Boolean]
  def aguardando?
    self.status.to_sym == :aguardando
  end

  # Método para calcular a média das respostas considerando o peso
  #
  # @return[BigDecimal]
  def calcular_media
    return if tb_respostas.blank?
    media = tb_respostas.map { |x| TbResposta.notas[x.nota] * x.tb_pergunta.peso }.sum / self.tb_respostas.map { |x| x.tb_pergunta.peso }.sum
    self.update_column(:media, media)
  end

  # protected instance methods ................................................
  # private instance methods ..................................................
  def verificar_empregados_iguais
    self.errors.add(:tb_empregado_gerente_id, 'não poder ao mesmo tempo o empregado avaliado!')
  end
end
