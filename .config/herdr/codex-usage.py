#!/usr/bin/env python3
"""Print cached Codex rate-limit usage for Herdr's status bar.

The script queries the official Codex App Server at most once per minute.  Herdr
calls its status command every five seconds, so keeping a cache prevents a new
App Server process (and a network request) for every redraw.
"""

import json
import os
import select
import subprocess
import sys
import time
from datetime import datetime
from pathlib import Path

CACHE_SECONDS = 60
REQUEST_TIMEOUT_SECONDS = 4
CACHE_FILE = Path(os.environ.get("XDG_CACHE_HOME", Path.home() / ".cache")) / "herdr" / "codex-usage.json"


def read_cache():
    try:
        payload = json.loads(CACHE_FILE.read_text())
        if time.time() - payload["fetched_at"] < CACHE_SECONDS:
            return payload["rate_limits"]
    except (FileNotFoundError, KeyError, ValueError, OSError):
        pass
    return None


def rpc_readline(process, request_id, deadline):
    while time.monotonic() < deadline:
        remaining = deadline - time.monotonic()
        ready, _, _ = select.select([process.stdout], [], [], max(remaining, 0))
        if not ready:
            break
        line = process.stdout.readline()
        if not line:
            break
        try:
            message = json.loads(line)
        except ValueError:
            continue
        if message.get("id") == request_id:
            return message.get("result")
    return None


def request_rate_limits():
    try:
        process = subprocess.Popen(
            ["codex", "app-server"],
            stdin=subprocess.PIPE,
            stdout=subprocess.PIPE,
            stderr=subprocess.DEVNULL,
            text=True,
            start_new_session=True,
        )
    except OSError:
        return None

    deadline = time.monotonic() + REQUEST_TIMEOUT_SECONDS

    def send(message):
        process.stdin.write(json.dumps(message) + "\n")
        process.stdin.flush()

    try:
        send(
            {
                "method": "initialize",
                "id": 1,
                "params": {
                    "clientInfo": {
                        "name": "herdr_status",
                        "title": "Herdr status bar",
                        "version": "1.0.0",
                    }
                },
            }
        )
        if rpc_readline(process, 1, deadline) is None:
            return None
        send({"method": "initialized", "params": {}})
        send({"method": "account/rateLimits/read", "id": 2, "params": {}})
        result = rpc_readline(process, 2, deadline)
        return result.get("rateLimits") if result else None
    except (BrokenPipeError, OSError):
        return None
    finally:
        process.terminate()
        try:
            process.wait(timeout=1)
        except subprocess.TimeoutExpired:
            process.kill()
            process.wait()


def format_window(window):
    if not window:
        return None
    used = window.get("usedPercent")
    duration = window.get("windowDurationMins")
    reset_at = window.get("resetsAt")
    if not isinstance(used, (int, float)) or not isinstance(duration, (int, float)):
        return None
    duration = int(duration)
    if duration >= 1440 and duration % 1440 == 0:
        label = f"{duration // 1440}d"
    elif duration >= 60 and duration % 60 == 0:
        label = f"{duration // 60}h"
    else:
        label = f"{duration}m"
    remaining = max(0, min(100, 100 - int(used)))
    if reset_at:
        try:
            reset_time = datetime.fromtimestamp(reset_at)
            reset_format = "%H:%M" if reset_time.date() == datetime.now().date() else "%m/%d %H:%M"
            return f"{label} 残{remaining}% ({reset_time.strftime(reset_format)})"
        except (OverflowError, OSError, TypeError, ValueError):
            pass
    return f"{label} 残{remaining}%"


def main():
    rate_limits = read_cache()
    if rate_limits is None:
        rate_limits = request_rate_limits()
        if rate_limits:
            try:
                CACHE_FILE.parent.mkdir(parents=True, exist_ok=True)
                CACHE_FILE.write_text(
                    json.dumps({"fetched_at": time.time(), "rate_limits": rate_limits})
                )
            except OSError:
                pass

    if not rate_limits:
        return
    windows = [format_window(rate_limits.get("primary")), format_window(rate_limits.get("secondary"))]
    print(" / ".join(window for window in windows if window))


if __name__ == "__main__":
    main()
