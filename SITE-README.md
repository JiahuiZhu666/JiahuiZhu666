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

The sharing image is `images/og.png`, generated with the built-in image-generation tool. Current edit brief: preserve all text, typography and layout; replace terracotta with Tiffany blue #81D8D0 and readable teal #087F78, use a cool near-white background #F7FCFB, and preserve the exact name, affiliation and research areas. The portrait and scientific figures are the original supplied assets.

The site uses a Tiffany blue palette, slightly larger type, full-width publication figures, and a Blogs section. Contact icons reuse the bundled Font Awesome and Academicons fonts, with accessible names and hover labels.

School logo sources: the WSU cougar SVG is extracted from the official https://www.wsu.edu/ homepage; the Boston University plate is from https://www.bu.edu/home/img/masterplate112x50-retina.png, referenced by its homepage stylesheet. Logos retain their university colors and proportions.

The IEEE CDC 2026 entry, “Boundary-Seeking Policy Gradient for Safe Reinforcement Learning,” uses Figure 2 from https://arxiv.org/abs/2608.10204 (v1). `images/bspg-cdc2026.png` is the unmodified original figure from the arXiv HTML version, showing BSPG and ESPO trajectories on the paper’s synthetic constrained problem. This is a method illustration, not the Safety-Gymnasium experiment. Title and author order follow arXiv; the conference is confirmed by the author and arXiv’s CDC 2026 comment.
