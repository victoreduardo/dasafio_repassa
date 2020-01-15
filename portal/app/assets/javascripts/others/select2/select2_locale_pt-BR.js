/**
 * Select2 Brazilian Portuguese translation
 */
(function ($) {
    "use strict";

    $.fn.select2.locales['pt-BR'] = {
        formatNoMatches: function () { return "Nenhum resultado encontrado"; },
        formatAjaxError: function () { return "Erro na busca"; },
        formatInputTooShort: function (input, min) { var n = min - input.length; return "Digite " + (min == 1 ? "" : "mais") + " " + n + " caractere" + (n == 1? "" : "s"); },
        formatInputTooLong: function (input, max) { var n = input.length - max; return "Apague " + n + " caractere" + (n == 1? "" : "s"); },
        formatSelectionTooBig: function (limit) { return "Só é possível selecionar " + limit + " elemento" + (limit == 1 ? "" : "s"); },
        formatLoadMore: function (pageNumber) { return "Carregando mais resultados…"; },
        formatSearching: function () { return "Buscando…"; }
    };

    $.extend($.fn.select2.defaults, $.fn.select2.locales['pt-BR']);
})(jQuery);
