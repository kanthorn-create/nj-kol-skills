#!/bin/bash
# NJ KOL Vault — Team API helper (shared by the kol-* skills).
#   kol.sh count '<filters-json>' [group]
#   kol.sh search '<filters-json>' [limit] [sort]
#   kol.sh lookalike <handle> ['<filters-json>'] [limit]
#   kol.sh profile <handle> [<handle> ...]
set -euo pipefail
HERE="$(cd "$(dirname "$0")" && pwd)"
URL="$(sed -n 's/.*"api_url": *"\([^"]*\)".*/\1/p' "$HERE/config.json")"
PUB="$(sed -n 's/.*"publishable_key": *"\([^"]*\)".*/\1/p' "$HERE/config.json")"
KEY_FILE="${NJ_KOL_KEY_FILE:-$HOME/.nj_kol_key}"
[ -s "$KEY_FILE" ] || { echo "ยังไม่มีคีย์ส่วนตัว — ขอจากผู้ดูแลระบบ แล้วบันทึกที่ $KEY_FILE (ดู SKILL.md)" >&2; exit 2; }
[ -n "$PUB" ] || { echo "config.json ยังไม่มี publishable_key" >&2; exit 2; }
KEY="$(cat "$KEY_FILE")"
mode="${1:-}"; filters="${2:-}"; [ -n "$filters" ] || filters="{}"
case "$mode" in
  count)  fn=kol_count;  body=$(printf '{"p_key":"%s","p_filters":%s%s}' "$KEY" "$filters" "${3:+,\"p_group\":\"$3\"}") ;;
  search) fn=kol_search; body=$(printf '{"p_key":"%s","p_filters":%s,"p_limit":%s,"p_sort":"%s"}' "$KEY" "$filters" "${3:-20}" "${4:-score}") ;;
  lookalike) fn=kol_lookalike; h="${2#@}"; f="${3:-}"; [ -n "$f" ] || f="{}"
          body=$(printf '{"p_key":"%s","p_handle":"%s","p_filters":%s,"p_limit":%s}' "$KEY" "$h" "$f" "${4:-20}") ;;
  profile) fn=kol_profile; shift; arr=""; for h in "$@"; do arr="$arr${arr:+,}\"${h#@}\""; done
          body=$(printf '{"p_key":"%s","p_handles":[%s]}' "$KEY" "$arr") ;;
  *) echo "usage: kol.sh count|search|lookalike|profile ... (see header)" >&2; exit 1 ;;
esac
curl -sS -X POST "$URL/$fn" -H "apikey: $PUB" -H "Authorization: Bearer $PUB" -H "Content-Type: application/json" -d "$body"
echo
