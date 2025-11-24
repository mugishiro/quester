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
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .

(function () {
  var MAX_CHARS = 1000;

  function updateCounter(area) {
    if (!area) return;
    var count = (area.value || "").replace(/\n/g, "改行").length;
    var wrapper = area.closest(".js-text-wrapper");
    if (!wrapper) return;
    var counter = wrapper.querySelector(".js-text-count");
    if (!counter) return;
    counter.textContent = count + "/" + MAX_CHARS;
    counter.style.color = count > MAX_CHARS ? "red" : "black";
  }

  function bindCounters() {
    var areas = document.querySelectorAll(".js-text");
    areas.forEach(function (area) {
      updateCounter(area);
      ["keyup", "input", "change"].forEach(function (ev) {
        area.addEventListener(ev, function () {
          updateCounter(area);
        });
      });
    });
  }

  document.addEventListener("DOMContentLoaded", bindCounters);
  document.addEventListener("turbolinks:load", bindCounters);
})();
