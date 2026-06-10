#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

REPORT_DIR="$PROJECT_DIR/service_reports"

CAS=$(date +"%d-%m-%Y_%H-%M-%S")

REPORT="$REPORT_DIR/service_report-$CAS.txt"

mkdir -p "$REPORT_DIR"
{
echo "Vytvarim service report"
echo "Slozka reportu: $REPORT_DIR"

echo

echo "Cas: $CAS"
echo "Report: $REPORT"
echo

"$SCRIPT_DIR/service-test.sh" "$@"
} | tee "$REPORT"

STAV=${PIPESTATUS[0]}
exit $STAV
