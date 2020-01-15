(function () {
    'use strict';

    var App = window.App || (window.App = {});

    App.select2ajaxMultiple = function (els) {
        if (!els) return;

        els.each(function () {
            applySelect2($(this));
        });
    };
    var selected_array = [];

    function applySelect2(el) {
        var url = el.data('url');

        el.select2({
            allowClear: true,
            multiple: true,
            minimumInputLength: 3,
            ajax: {
                url: url,
                dataType: 'json',
                data: function(term) {
                    var jsonParams = {q: term};
                    return jsonParams;
                },
                results: function (data, page) {
                    return {results: data};
                }
            },
            initSelection: function (element, callback) {
                var id = $(element).val();
                if (id === '') return;

                // $.ajax(url + '?id=' + id, {dataType: 'json'}).done(function (data) {
                //
                // });
                $.ajax({
                    type: 'GET',
                    url: url + '?id=' + id,
                    dataType: 'json', // ** ensure you add this line **
                    success: function (data) {
                        callback(data)
                        console.log(data);
                        // $(element).select2("data",data);
                        // jQuery.each(data, function(index, item) {
                        //     console.log(item)
                        //     //now you dcan access properties using dot notation
                        // });
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        alert("Ocorreu um erro ao processar a requisição");
                    }
                });
            }
        });
        ;
    }
}).call(this);