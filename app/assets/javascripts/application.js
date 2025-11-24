// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .

$(document).on('turbolinks:load', function () {
  var MAX_CHARS = 1000;

  function updateCounter($area) {
    var count = ($area.val() || "").replace(/\n/g, "改行").length;
    var $counter = $area.closest(".js-text-wrapper").find(".js-text-count");
    if (!$counter.length) return;

    $counter.text(count + "/" + MAX_CHARS);
    if (count > MAX_CHARS) {
      $counter.css("color", "red");
    } else {
      $counter.css("color", "black");
    }
  }

  $(".js-text").each(function () {
    var $area = $(this);
    updateCounter($area);
    $area.on("keyup input change", function () {
      updateCounter($area);
    });
  });
});
