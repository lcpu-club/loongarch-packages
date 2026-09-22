#!/bin/bash
# loong64 workarounds for JS build dependencies that have no native binding:
#   - @swc/core: wire up its official @swc/wasm fallback
#   - vite-plugin-lib-inject-css: it only uses @ast-grep/napi to locate where the
#     CSS import should be injected; injecting at position 0 is equivalent for the
#     ES output used here and avoids the unsupported native module
set -euo pipefail

base="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
js="$(dirname "$base")"

# @swc/core: make @swc/wasm resolvable and let the fallback branch be reached
mkdir -p "$js/node_modules/@swc"
rm -rf "$js/node_modules/@swc/wasm"
cp -r "$base/wasm" "$js/node_modules/@swc/wasm"

shopt -s nullglob
for f in "$js"/node_modules/.pnpm/@swc+core@*/node_modules/@swc/core/index.js; do
  sed -i 's|var binding_1 = require("./binding");|var binding_1 = {}; try { binding_1 = require("./binding"); } catch (e) {}|' "$f"
done

# vite-plugin-lib-inject-css: drop the @ast-grep/napi dependency
for f in "$js"/node_modules/.pnpm/vite-plugin-lib-inject-css@*/node_modules/vite-plugin-lib-inject-css/dist/index.js; do
  sed -i \
    -e '\|^import { Lang, parse } from "@ast-grep/napi";$|d' \
    -e 's|const node = parse(Lang.JavaScript, chunk.code).root().children().find((node2) => !excludeTokens.includes(node2.kind()));|const position = 0;|' \
    -e '/const position = node?.range().start.index ?? 0;/d' \
    "$f"
done
