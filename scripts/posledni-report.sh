#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

REPORT_DIR="$PROJECT_DIR/reports"

zkontroluj_help(){
 if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
  ukaz_pouziti
  exit 0
 fi
}

navod(){
 if [ "$1" -gt 0 ]; then
  ukaz_pouziti
  exit 1
 fi
}

existuje_slozka() {
 if [ ! -d "$1" ]; then
  echo "Slozka $1 neexistuje"
  exit 1
 fi
}

najdi_nejnovejsi_report(){
 ls -t "$1" | head -n 1
}

report_nenalezen() {
 if [ -z "$1" ]; then
  echo "Nenalezen zadny $2"
  exit 1
 fi
}

cteni_reportu() {
 echo "Nejnovejsi $1 je: $2"
 cat "$1/$2"
}
ukaz_pouziti() {
 echo "Pouziti: ./skripts/posledni-report.sh"
 echo "Vypise nejnovejsi report ze slozky reports"
}

main(){

zkontroluj_help "$1"

navod "$#"

echo "Hledam posledni $REPORT_DIR"

existuje_slozka "$REPORT_DIR"



NEJNOVSI=$(najdi_nejnovejsi_report "$REPORT_DIR")

report_nenalezen "$NEJNOVSI" "$REPORT_DIR"

cteni_reportu "$REPORT_DIR" "$NEJNOVSI"
}

main "$@"
