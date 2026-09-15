#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
bundle exec jekyll build --config _config.yml,_config.preview.yml --destination dist/client
bundle exec ruby scripts/check-site.rb dist/client ''
mkdir -p dist/server
cp worker/index.js dist/server/index.js
