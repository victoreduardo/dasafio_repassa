$(document).on('turbolinks:load', function () {
    const App = window.App || (window.App = {});
    App.select2ajax($('.select2ajax'));
    App.select2ajaxMultiple($('.select2ajaxMultiple'));

    $('.input-money').maskMoney();
    $('.nmr-cpf').mask('000.000.000-00', {reverse: true});
    $('.date-picker').datepicker({
        autoclose: true,
        clearBtn: true,
        language: 'pt-BR',
        format: 'dd/mm/yyyy',
        todayBtn: 'linked',
        forceParse: false
    });
    $('.data-format, .date-picker').mask('00/00/0000', {reverse: false});
});
