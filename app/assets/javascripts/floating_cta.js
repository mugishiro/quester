// Floating CTA: show after scroll on desktop, always show on mobile
(function () {
  var button;
  function ensureButton() {
    if (button && !document.body.contains(button)) {
      button = null;
    }
    if (button) return;
    button = document.createElement("a");
    button.href = document.body.dataset.newPostPath || "#";
    button.className = "floating-cta";
    button.innerHTML = '<span class="floating-cta__icon">＋</span><span class="floating-cta__label">質問する</span>';
    document.body.appendChild(button);
  }

  function toggleButton() {
    if (!document.body.dataset.newPostPath) {
      if (button) button.classList.remove("is-visible");
      return;
    }
    var isMobile = window.matchMedia("(max-width: 768px)").matches;
    var scrolled = window.pageYOffset > 120;
    if (isMobile || scrolled) {
      ensureButton();
      button.classList.add("is-visible");
    } else if (button) {
      button.classList.remove("is-visible");
    }
  }

  document.addEventListener("turbolinks:load", function () {
    toggleButton();
  });
  window.addEventListener("scroll", toggleButton);
  window.addEventListener("resize", toggleButton);
})();
