(function () {
  const App = window.App || (window.App = {});

  function applySelect2(el) {
    const url = el.data('url');

    el.select2({
      placeholder: el.attr('placeholder'),
      allowClear: true,
      minimumInputLength: 3,
      ajax: {
        url: url,
        dataType: 'json',
        data: function(term) {
          const jsonParams = { q: term };
          const paramName = el.data('param-name');
          const paramValue = el.data('param-value');

          if (paramName && paramValue) jsonParams[paramName] = paramValue;

          return jsonParams;
        },
        results: function(data) {
          return { results: data };
        },
      },
      initSelection: function(element, callback) {
        const id = $(element).val();
        if (id === '') return;

          $.ajax(url + '?id='+id, { dataType: 'json' }).done(function(data) { callback(data); });
      },
    });
  }

  App.select2ajax = (function(els) {
    if (!els) return;

    els.each(function () {
      applySelect2($(this));
    });
  });
}).call(this);
