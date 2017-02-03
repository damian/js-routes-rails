const JsRoutesRails = (function() {
  var routes = {};
  <% @routes.each do |helper, path| %>
  routes['<%= helper %>'] = function(options) {
    return format('<%= path %>', options);
  };
  <% end %>

  function format(string, options) {
    var str = string.toString();
    for (var option in options) {
      str = str.replace(RegExp("\\:" + option, "gi"), options[option]);
    }

    return str;
  };

  return routes;
})();

export { JsRoutesRails };
