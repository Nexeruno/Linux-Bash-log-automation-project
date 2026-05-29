#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
CAS=$(date +"%d.%m.%Y_%H:%M:%S")
LOG_DIR="logs"
REPORT_DIR="$PROJECT_DIR/reports"

zkontroluj_help() {
 if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
  ukaz_pouziti
  exit 0
 fi
}

kontrola_cesty(){
 local CESTA="$1"

  if [ ! -d "$CESTA" ] && [ -d "$PROJECT_DIR/$CESTA" ]; then
   echo "$PROJECT_DIR/$CESTA"
  else
   echo "$CESTA"
  fi
}

moc_argumentu() {
 if [ "$1" -gt 1 ]; then
  ukaz_pouziti
  chyba "Moc argumentu"
 fi
}

kontrola_slozky() {
 if [ "$1" -eq 1 ]; then
  LOG_DIR="$2"
 fi
}

vytvoreni_slozky() {
 mkdir -p "$1" || chyba "Nepodarilo se vytvorit slozku $1"
}

ulozeni_reportu() {
 echo "Cas je: $1"
 echo "Report bude: $2"
}

report_zprava() {
{
 echo "Report kontroly logu"
 echo "Cas: $1"
 echo "Slozka s logy: $2"
 echo "-----------------------"
 "$SCRIPT_DIR/kontrola-vsech-logu.sh" "$2"
} | tee "$3"

local STAV=${PIPESTATUS[0]}


return "$STAV"
}
vysledek_reportu() {
 echo "Report vytvoren: $1"
 echo "Vysledek kontroly: $2"
}

vysledek_kontroly(){
 if [ "$1" -eq 0 ]; then
  echo "Kontrola dopadla OK"
 else
  echo "Kontrola ma problem"
 fi

 exit $1
}

ukaz_pouziti() {
 echo "Pouziti: ./skripts/vytvor-report.sh [SLOZKA_S_LOGY]"
 echo "Priklad: ./skripts/vytvor-report.sh logs"
}

chyba() {
 echo "CHYBA: $1"
 exit 1
}

main(){

zkontroluj_help "$1"

moc_argumentu "$#"

kontrola_slozky "$#" "$1"

LOG_DIR=$(kontrola_cesty "$LOG_DIR")

vytvoreni_slozky "$REPORT_DIR"

REPORT="$REPORT_DIR/report-$CAS.txt"

ulozeni_reportu "$CAS" "$REPORT"

report_zprava "$CAS" "$LOG_DIR" "$REPORT"
STAV=$?

vysledek_reportu "$REPORT" "$STAV"

vysledek_kontroly "$STAV"
}

main "$@"
