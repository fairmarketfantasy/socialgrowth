// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .




(function() {

  window.App || ( window.App = {} )

	var toggleBtnWithId = function(id, remove, add) {
    var btn = $("#" + id);
    var hidden = $("#hidden_" + id);

    var oldClass = btn.attr("data-" + hidden.val()).split(" ")[1];
    var newValue = toggleString(hidden.val());
    var attributes = btn.attr("data-" + newValue).split(" ");

    hidden.val(newValue);
    btn.html(attributes[0]);
    btn.removeClass(oldClass);
    btn.addClass(attributes[1]);
  }

  var toggleString = function(bool) {
    return bool == "true" ? "false" : "true"
  }
  
  App.toggleBtn = toggleBtnWithId

})();