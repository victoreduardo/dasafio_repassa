/**
 * Created by Victor Eduardo on 12/12/2014.
 */
$(document).ready(function () {
    $('[type="reset"]').click(function () {
        var frm_elements = $(this).closest("form")[0].elements;
        for (var i = 0; i < frm_elements.length; i++) {
            field_type = frm_elements[i].type.toLowerCase();
            switch (field_type) {
                case "radio":
                    if ($(frm_elements[i]).checked) {
                        $(frm_elements[i]).checked = false;
                        $(frm_elements[i]).prop('checked', false);
                    }
                    break;
                case "checkbox":
                    if ($(frm_elements[i]).checked) {
                        $(frm_elements[i]).checked = false;
                        $(frm_elements[i]).prop('checked', false);
                    }
                    break;
                case "select":
                    $(frm_elements[i]).find('option').attr('selected', false);
                    break;
                case "select-one":
                    $(frm_elements[i]).find('option').attr('selected', false);
                    break;
                case "select-multi":
                    $(frm_elements[i]).find('option').attr('selected', false);
                    break;
                case 'number':
                    $("#" + frm_elements[i].id).val('');
                    document.getElementById(frm_elements[i].id).value = "";
                    document.getElementById(frm_elements[i].id).setAttribute('value', '');
                    frm_elements[i].value = "";
                    $(frm_elements[i]).val("").removeAttr('value');
                    break;
                default:
                    frm_elements[i].value = "";
                    $(frm_elements[i]).value = "";
                    $(frm_elements[i]).val("").removeAttr('value');
                    break;
            }
        }
    });
});
function getAjax(url, data, success, error) {
    $.ajax({
        type: 'GET',
        url: url,
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        data: data,
        success: success,
        before: null,
        error: error
    });
}
function postAjax(url, data, success, error) {
    $.ajax({
        type: 'POST',
        url: url,
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        data: data,
        success: success,
        before: null,
        error: error
    });
}
function setAjax(url, dataType, data, success, error) {
    $.ajax({
        type: 'POST',
        url: url,
        data: data,
        success: success,
        dataType: dataType,
        error: error
    });
}
function deleteAjax(url, data, success, error) {
    $.ajax({
        type: 'DELETE',
        url: url,
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        data: data,
        success: success,
        before: null,
        error: error
    });
}
function form_required_message(id) {
    var form = $(id);
    var submitButton = form.find('button[type="submit"]');
    submitButton.on("click", function () {
        if ($("input[type!='hidden'], textarea[type!='hidden'], input[required='requered'], input[requered='true']", form).filter(":visible").filter("[requered]").not("input[disabled],textarea[disabled]").filter(function () {
                return $.trim($(this).val()) === "";
            }).size() > 0) {
            show_messager_empty(form);
            return false;
        }
        else
            return true;
    });
}

function show_messager_empty(form) {
    if ($("input[type!='hidden'], textarea[type!='hidden'], input[required='requered'], input[requered='true']", form).filter(":visible").filter("[requered]").not("input[disabled],textarea[disabled]").filter(function () {
            return $.trim($(this).val()) === "";
        }).size() > 0) {
        var campo = $("input[type!='hidden'], textarea[type!='hidden'], input[required='requered'], input[requered='true']", form).filter(":visible").filter("[requered]").not("input[disabled],textarea[disabled]").filter(function () {
            return $.trim($(this).val()) === "";
        }).first();
        $(campo).focus();
        var nme_campo = $(campo).data("name");
        if (nme_campo == null || nme_campo.trim() == "")
            nme_campo = $(campo).parent().parent().children().first().text();
        swal("Campo Obrigatório em branco!", "Campo " + nme_campo + " é Obrigatório.", "warning");
        return false;
    } else
        return true;
}
function validarCPF(value) {
    $return = true;

    // this is mostly not needed
    var invalidos = [
        '111.111.111-11',
        '222.222.222-22',
        '333.333.333-33',
        '444.444.444-44',
        '555.555.555-55',
        '666.666.666-66',
        '777.777.777-77',
        '888.888.888-88',
        '999.999.999-99',
        '000.000.000-00'
    ];
    for (i = 0; i < invalidos.length; i++) {
        if (invalidos[i] == value) {
            $return = false;
        }
    }

    value = value.replace("-", "");
    value = value.replace(/\./g, "");

    //validando primeiro digito
    add = 0;
    for (i = 0; i < 9; i++) {
        add += parseInt(value.charAt(i), 10) * (10 - i);
    }
    rev = 11 - ( add % 11 );
    if (rev == 10 || rev == 11) {
        rev = 0;
    }
    if (rev != parseInt(value.charAt(9), 10)) {
        $return = false;
    }

    //validando segundo digito
    add = 0;
    for (i = 0; i < 10; i++) {
        add += parseInt(value.charAt(i), 10) * (11 - i);
    }
    rev = 11 - ( add % 11 );
    if (rev == 10 || rev == 11) {
        rev = 0;
    }
    if (rev != parseInt(value.charAt(10), 10)) {
        $return = false;
    }

    return $return;
}
function sameDay(d1, d2) {
    return d1.getUTCFullYear() == d2.getUTCFullYear() &&
        d1.getUTCMonth() == d2.getUTCMonth() &&
        d1.getUTCDate() == d2.getUTCDate();
}