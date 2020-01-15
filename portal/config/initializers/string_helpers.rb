class Integer
  def to_b?
    !self.zero?
  end
end
class String

  def nome_proprio
    self.titleize.gsub(/ D(a|e|o|as|os) /, ' d\1 ').gsub(/ E /, ' e ')
  end

  def is_email?
    return self.match(/[a-zA-Z0-9._%]@(?:[a-zA-Z0-9]+\.)[a-zA-Z]{2,4}/)
  end

  def num_to_phone
    num = self
    size_medium = num.length == 11 ? 6 : 5
    "(#{num[0..1] }) #{ num[2..size_medium] }-#{ num[(size_medium + 1)..-1] }"
  end

  # Remove todas as tags html de uma string
  def strip_tags_custom
    ActionController::Base.helpers.strip_tags(self)
  end

  def is_number?
    true if Float(self) rescue false
  end

  def is_uuid?
    return true if self =~ /\A[\da-f]{32}\z/i ||
        self =~ /\A(urn:uuid:)?[\da-f]{8}-([\da-f]{4}-){3}[\da-f]{12}\z/i rescue false
  end

  def retira_caracteres_especiais(apenas_numeros=false)
    apenas_numeros ? self.gsub(/[^0-9]/, '') : self.gsub(/[^0-9A-Za-z]/, '')
  end

  def r_text(size,filler=' ')
    self.to_s.remover_acentos[0..(size.to_i-1)].ljust(size, filler).upcase
  end

  def r_number(size, filler='0')
    self[0..(size.to_i-1)].rjust(size,filler)
  end

  def r_dinheiro(size=13, filler='0')
    self.to_f.to_dinheiro_s_cifra.gsub(',','').gsub('.','').rjust(size,filler)
  end

  def r_dinheiro_c_ponto(size=13, filler='0')
    self.to_f.to_dinheiro_s_cifra.gsub(',','').rjust(size,filler)
  end

  def status_to_s
    case self
      when STATUS_CANCELADO
        'CANCELADO'
      when STATUS_PENDENTE
        'PENDENTE'
      when STATUS_CONCLUIDO
        'CONCLUIDO'
      when STATUS_ACEITO
        'ACEITO'
      when STATUS_NEGADO
        'NEGADO'
      when STATUS_RETORNADO
        'RETORNADO'
      else
        ''
    end
  end

  def tipo_entrada_to_s
    case self
      when TIPO_DOACAO
        'DOAÇÃO'
      when TIPO_NOTA_FISCAL
        'NOTA FISCAL'
      when TIPO_PRODUCAO_PROPRIA
        'PRODUÇÃO PRÓPRIA'
      else
        'TODOS'
    end
  end

  def to_date_recad
    Date.strptime(self, "%d%m%Y") if self.present? and self.size == 8
  end


  def to_bool
    return true if self == true || self =~ (/^(true|t|yes|y|1)$/i)
    return false if self == false || self.blank? || self =~ (/^(false|f|no|n|0)$/i)
    raise ArgumentError.new("invalid value for Boolean: \"#{self}\"")
  end

  # Remove as letras acentuadas
  #
  # Exemplo:
  #  String.remover_acentos('texto está com acentuação') ==> 'texto esta com acentuacao'
  def remover_acentos
    return self if self.blank?
    texto = self
    texto = texto.gsub(/(á|à|ã|â|ä)/, 'a').gsub(/(é|è|ê|ë)/, 'e').gsub(/(í|ì|î|ï)/, 'i').gsub(/(ó|ò|õ|ô|ö)/, 'o').gsub(/(ú|ù|û|ü)/, 'u')
    texto = texto.gsub(/(Á|À|Ã|Â|Ä)/, 'A').gsub(/(É|È|Ê|Ë)/, 'E').gsub(/(Í|Ì|Î|Ï)/, 'I').gsub(/(Ó|Ò|Õ|Ô|Ö)/, 'O').gsub(/(Ú|Ù|Û|Ü)/, 'U')
    texto = texto.gsub(/ñ/, 'n').gsub(/Ñ/, 'N')
    texto = texto.gsub(/ç/, 'c').gsub(/Ç/, 'C')
    texto
  end
end