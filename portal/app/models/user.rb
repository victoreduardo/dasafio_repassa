class User < ActiveRecord::Base
  # main config ...............................................................
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  # extends ...................................................................
  # includes ..................................................................
  # security (i.e. attr_accessible) ...........................................
  # relationships .............................................................
  belongs_to :tb_empregado
  # validations ...............................................................
  # callbacks .................................................................
  # scopes ....................................................................
  # additional config .........................................................
  # class methods .............................................................
  # public instance methods ...................................................

  # Retorna se o usuário é ou não administrador
  #
  # @return[Boolean]
  def e_admin?
    e_admin
  end

  # Retorna se o usuário é ou não gerente
  #
  # @return[Boolean]
  def e_gerente?
    return false if tb_empregado.blank?
    tb_empregado&.tb_cargo&.chave&.to_sym == :gerente
  end
  # protected instance methods ................................................
  # private instance methods ..................................................
end
