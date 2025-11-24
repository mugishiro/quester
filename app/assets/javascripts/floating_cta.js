// Floating CTA: show after scroll on desktop, always show on mobile
(function () {
  var button;
  var postPath;

  function resolvePath() {
    var bodyPath = document.body ? document.body.dataset.newPostPath : null;
    if (bodyPath && bodyPath.length > 0) {
      postPath = bodyPath;
    }
    return postPath;
  }

  function ensureButton() {
    if (button && !document.body.contains(button)) {
      button = null;
    }
    if (button) {
      button.href = resolvePath() || "#";
      return;
    }
    button = document.createElement("a");
    button.href = resolvePath() || "#";
    button.className = "floating-cta";
    button.innerHTML = '<span class="floating-cta__icon">＋</span><span class="floating-cta__label">質問する</span>';
    document.body.appendChild(button);
  }

  function toggleButton() {
    if (!resolvePath()) {
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
    resolvePath();
    toggleButton();
  });
  window.addEventListener("scroll", toggleButton);
  window.addEventListener("resize", toggleButton);
})();
