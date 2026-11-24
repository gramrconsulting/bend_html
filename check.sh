#!/usr/bin/env bash
# Ready check: PROOF.bend proves every law.
set -euo pipefail
cd "$(dirname "$0")"
bend PROOF.bend | grep -q 'ALL PROOFS CHECK' || { bend PROOF.bend; exit 1; }
echo OK
