# japanese-guard

A Claude Code hook that makes Claude rewrite its response in Japanese when it switches to English.

## Source

`hooks/japanese-guard.py` was taken from
[minorun365/claude-code-japanese-guard](https://github.com/minorun365/claude-code-japanese-guard)
at commit [`2b4965f`](https://github.com/minorun365/claude-code-japanese-guard/commit/2b4965f31b8859ec71dea06395a0aecf15e68da1).
The script is unmodified.

It is licensed under the Apache License 2.0. The upstream [LICENSE](LICENSE) and [NOTICE](NOTICE) are included as-is.

## Setup

The hook is registered in `hooks.Stop` and `hooks.PreToolUse` (matcher: `mcp__.*__wrap_up`) in `.claude/settings.json`.
The `command` is `python3 ~/.claude/scripts/japanese-guard/japanese-guard.py` because zsh's `alias -s py=python`
would otherwise hand `.py` files to `python` when run directly.

---------

Thanks a lot, @minorun365! This hook is a huge help.
