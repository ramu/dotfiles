#!/bin/sh
# herdr の tab bar 右端に表示するステータス (CPU / バッテリー)。
# 出力は最終行のみが使われる。
#
# herdr は command エントリの出力から ANSI エスケープを取り除くため文字色は付けられない
# (\033[32m は画面に "[32m" と出てしまう)。絵文字・記号はそのまま表示されるので、
# 状態は絵文字インジケータで表す。

PATH=/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
export PATH

# --- CPU ---
cpu=$(top -l 1 -n 0 2>/dev/null | grep 'CPU usage' | sed 's/.*: //' | awk '{print $1}')
cpu_int=${cpu%%.*}
cpu_int=${cpu_int%\%}
case $cpu_int in
  ''|*[!0-9]*) cpu_int=-1 ;;
esac
if   [ "$cpu_int" -lt 0 ];  then cpu_icon='⚪'; cpu='?'
elif [ "$cpu_int" -lt 50 ]; then cpu_icon='🟢'
elif [ "$cpu_int" -lt 80 ]; then cpu_icon='🟡'
else                             cpu_icon='🔴'
fi

# --- バッテリー ---
batt_line=$(pmset -g batt 2>/dev/null)
batt=$(printf '%s\n' "$batt_line" | awk '/InternalBattery/{print $3}' | tr -d ';')
batt_int=${batt%\%}
case $batt_int in
  ''|*[!0-9]*) batt_int=-1 ;;
esac
if printf '%s\n' "$batt_line" | grep -q 'AC Power'; then
  if [ "$batt_int" -ge 100 ]; then batt_icon='🔌'; else batt_icon='⚡'; fi
elif [ "$batt_int" -ge 0 ] && [ "$batt_int" -lt 20 ]; then
  batt_icon='🪫'
else
  batt_icon='🔋'
fi
[ "$batt_int" -lt 0 ] && batt='?'

printf '%s CPU %s %s %s\n' "$cpu_icon" "$cpu" "$batt_icon" "$batt"
