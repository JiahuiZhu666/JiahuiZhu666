(function () {
  'use strict';
  var root = document.documentElement;
  var themeButton = document.querySelector('.theme-toggle');
  function updateThemeLabel() {
    var dark = root.dataset.theme === 'dark';
    themeButton.setAttribute('aria-label', 'Switch to ' + (dark ? 'light' : 'dark') + ' theme');
    themeButton.setAttribute('title', 'Switch to ' + (dark ? 'light' : 'dark') + ' theme');
    themeButton.firstElementChild.textContent = dark ? '☀' : '◐';
  }
  updateThemeLabel();
  themeButton.addEventListener('click', function () {
    root.dataset.theme = root.dataset.theme === 'dark' ? 'light' : 'dark';
    try { localStorage.setItem('jiahui-theme', root.dataset.theme); } catch (_) {}
    updateThemeLabel();
  });
  var navLinks = Array.from(document.querySelectorAll('.site-nav a'));
  var sections = navLinks.map(function (link) { return document.getElementById(link.dataset.section); }).filter(Boolean);
  var progress = document.querySelector('.reading-progress');
  var backToTop = document.querySelector('.back-to-top');
  var scheduled = false;
  function updateScroll() {
    var distance = root.scrollHeight - window.innerHeight;
    progress.style.transform = 'scaleX(' + (distance > 0 ? Math.min(1, window.scrollY / distance) : 0) + ')';
    backToTop.classList.toggle('visible', window.scrollY > 480);
    var active = sections[0];
    sections.forEach(function (section) { if (section.getBoundingClientRect().top <= 160) active = section; });
    navLinks.forEach(function (link) {
      var current = Boolean(active && link.dataset.section === active.id);
      link.classList.toggle('active', current);
      if (current) link.setAttribute('aria-current', 'location'); else link.removeAttribute('aria-current');
    });
    scheduled = false;
  }
  window.addEventListener('scroll', function () { if (!scheduled) { scheduled = true; requestAnimationFrame(updateScroll); } }, { passive: true });
  window.addEventListener('resize', updateScroll);
  updateScroll();
  document.querySelectorAll('.copy-citation').forEach(function (button) {
    button.addEventListener('click', async function () {
      var code = button.parentElement.querySelector('code');
      try {
        await navigator.clipboard.writeText(code.textContent);
        button.textContent = 'Copied!';
      } catch (_) {
        var range = document.createRange();
        range.selectNodeContents(code);
        var selection = window.getSelection();
        selection.removeAllRanges();
        selection.addRange(range);
        button.textContent = 'Select & copy';
      }
      window.setTimeout(function () { button.textContent = 'Copy'; }, 2200);
    });
  });
})();
