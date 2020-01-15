module ApplicationHelper
  include AlertsHelper
  include TranslateHelper
  include ComponentsHelper

  JS_ESCAPE_MAP = {
      '\\' => '\\\\',
      '<' => '\\u003c',
      '&' => '\\u0026',
      '>' => '\\u003e',
      "\r\n" => '\n',
      "\n" => '\n',
      "\r" => '\n',
      '"' => '\\u0022',
      "'" => "\\u0027"
  }

  JS_ESCAPE_MAP["\342\200\250".force_encoding(Encoding::UTF_8).encode!] = '&#x2028;'
  JS_ESCAPE_MAP["\342\200\251".force_encoding(Encoding::UTF_8).encode!] = '&#x2029;'

  def escape_javascript_with_inside_html(javascript)
    if javascript
      result = javascript.gsub(/(\\|\r\n|\342\200\250|\342\200\251|[\n\r<>&"'])/u) { |match| JS_ESCAPE_MAP[match] }
      javascript.html_safe? ? result.html_safe : result
    else
      ''
    end
  end

  alias_method :jh, :escape_javascript_with_inside_html

  # Retorna a classe bootstrap para estilizar mensagens de alerta
  #
  # @return[String]
  def check_alert(name)
    case name
    when :notice
      'success'
    when :danger
      'danger'
    when :warning
      'warning'
    else
      'info'
    end
  end

  # Retorna o icone font-awesome para estilizar mensagens de alerta
  #
  # @return[String]
  def check_alert_icon(name)
    case name
    when :danger
      'fa-exclamation-circle'
    when :warning
      'fa-question-circle'
    when :notice, :success
      'fa-check-circle'
    else
      'fa-info-circle'
    end
  end

  # Define um input para dinheiro
  #
  # @return[Html]
  def input_dinheiro_precisao(form, field, label = nil, id = nil, place_holder = nil, required = false, separador_centena = nil,
                              separador_centavos = nil, complemento = nil, label_col = 'col-md-2', control_col = 'col-md-10',
                              precisao = 2, classe = '')
    html = "
    #{form.text_field field,
                      value: (Util.formata_moeda_sem_ponto(form.object.attributes[field.to_s]) if form.object.attributes[field.to_s]),
                      label: label, name: "#{id}_mask_money", "id" => "#{id}_mask_money", placeholder: place_holder,
                      data_required: required,
                      hide_label: label.nil?,
                      class: "form-control input-money #{classe}", "data-decimal" => separador_centavos,
                      "data-thousands" => separador_centena,
                      onkeyup: "$(\"[name='#{form.object_name}[#{field}]']\").val(this.value.replace(/\\./g, '').replace(/\\,/g,'.'));"}
    #{form.hidden_field field}
     <script>
      jQuery(document).ready(function () {
          $('.input-money').maskMoney({
          precision: #{precisao}
        });
      });
    </script>
     "
    html.html_safe
  end

  # Permite a criação da ordenação das listagens
  #
  # @return[Link]
  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    sort_icon = ""

    if column == sort_column
      if sort_direction == "asc"
        sort_icon = "<span class='fa fa-sort-asc'></span> "
      elsif sort_direction == "desc"
        sort_icon = "<span class='fa fa-sort-desc'></span> "
      end
    else
      sort_icon = "<span class='fa fa-sort-asc'></span> "
    end

    link_to (sort_icon + title).html_safe, request.parameters.merge(sort: column, direction: direction, page: nil), class: css_class
  end

  # Cria um link para editar
  #
  # @param path [String] path de editar
  # @param options [String] path de editar
  def link_to_edit(path, options = {})
    link_to path,
            class: options[:class] || "btn btn-warning btn-xs",
            title: options[:title] || "Alterar",
            style: "color: #FFF; " do
      content_tag :span, class: options[:icon] || "fa fa-pencil" do
        options[:label] if options[:label]
      end

    end
  end

  # Cria um link para visualizar
  #
  # @param path [String] path de visualização
  def link_to_show(path, target = nil)
    link_to path,
            class: 'btn btn-info btn-xs',
            title: 'Visualizar',
            style: 'color: #FFF; float: none;',
            target: nil do
      content_tag :span, class: 'fa fa-search' do
      end
    end
  end

  # Cria um link para Excluir
  #
  # @param path [String] path de excluir
  def link_to_destroy(path, *options)
    klass = "btn btn-danger btn-xs"
    klass = options.first[:class] if options.present? && options.first[:class]
    link_to path,
            method: "delete",
            class: klass,
            title: "Excluir",
            data: { confirm: label_translate(:confirm_delete),
                    'confirm-button-text': "Confirmar",
                    'cancel-button-text': "Cancelar",
                    'confirm-button-color': "#66CD00",
                    'cancel-button-color': "#ff0000",
                    'sweet-alert-type': "warning",
            },
            style: "color: #FFF; float: none;" do
      content_tag :span, class: "fa fa-trash-o" do
      end
    end
  end

  def options_from_enum_for_select(instance, enum)
    options_for_select(enum_collection(instance, enum), instance.send(enum))
  end

  def enum_collection(instance, enum)
    instance.class.send(enum.to_s.pluralize).keys.to_a.map { |key| [key.humanize, key] }
  end

end
