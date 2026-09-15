# Jiahui Zhu — redesigned research homepage

The site remains a Jekyll / GitHub Pages project. The redesign takes visual inspiration from https://zhangce01.github.io/ and uses independently written layout, CSS, and JavaScript. No reference-site biography, publications, photos, or code were copied into the website.

## Edit content

- `_data/profile.json`: publication titles, authors, links, profile links, and education.
- `_includes/research-home.html`: introduction, research directions, news, writing cards, and talks.
- `_posts/`: individual notes and presentations.
- `files/`: downloadable slides, published with the site.
- `assets/css/research.css`: responsive layout and light/dark colors.
- `assets/js/research.js`: theme control, navigation tracking, reading progress, and citation copying.

Original photos and paper figures remain in `images/`. The two slide pages now have distinct addresses. `/my-presentation.html` redirects to Generative Pre-Training, while Score Matching is at `/score-matching.html`.

## Build and preview

Use Ruby with Bundler 2.2.19, as recorded in `Gemfile.lock`. The existing GitHub Actions workflow uses Ruby 3.1.

```sh
bundle install
bundle exec jekyll build
bundle exec jekyll serve --host 127.0.0.1
```

Open `http://127.0.0.1:4000/JiahuiZhu666/`. The existing workflow builds with the GitHub Pages base path when published.

Publishing to the original GitHub repository requires a push; local changes do not update the current live website.

## Private Sites preview

`bash scripts/build-preview.sh` produces the separate Sites build in `dist/`, using `_config.preview.yml`. It retains the original GitHub Pages build and base path. `worker/index.js` serves the generated assets and derives social metadata from the incoming host. `bundle exec ruby scripts/check-site.rb` checks the GitHub Pages build for missing routes, files, and anchors.

The sharing image is `images/og.png`, generated with the built-in image-generation tool. Brief: warm ivory dot grid, terracotta accents, Space Grotesk-like typography; exact name “Jiahui Zhu”, affiliation “Washington State University”, and research areas “LLM Reasoning · Reinforcement Learning” / “Constrained Optimization”, with three restrained numbered research panels. The portrait and scientific figures are the original supplied assets.
