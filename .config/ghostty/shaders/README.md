# ghostty shaders

Ghostty の `custom-shader` に指定するカーソルシェーダを置くディレクトリ。

`~/.config/ghostty` が dotfiles へのシンボリックリンクなので、ここに `.glsl` を
置けば別マシンでも `setup.sh` の実行だけで有効になる（追加の clone は不要）。

## ファイル

| ファイル | 出典 | 取得元コミット |
|---|---|---|
| `cursor_warp.glsl` | [sahaj-b/ghostty-cursor-shaders](https://github.com/sahaj-b/ghostty-cursor-shaders) | `0a274beac8b93ee6ce6b94402b7313a0417b8e38` (2026-06-16) |

上流のファイルを無改変で取り込んでいる。パラメータ調整はファイル冒頭の
`--- CONFIGURATION ---` ブロックを編集する。上流には他に 6 種類のシェーダが
あるので、切り替えたくなったらそこから追加で取得する。

## 使い方

`config.ghostty` に以下を記述する。

```
custom-shader = shaders/cursor_warp.glsl
custom-shader-animation = always
```

## ライセンス

`cursor_warp.glsl` は上流リポジトリの MIT ライセンスに従う。

```
MIT License

Copyright (c) 2026 Sahaj Bhatt

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
