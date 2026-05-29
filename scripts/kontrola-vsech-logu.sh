#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

LOG_DIR="logs"

kontrola_cesty(){
 local CESTA="$1"
  if [ ! -d "$CESTA" ] && [ -d "$PROJECT_DIR/$CESTA" ]; then
   echo "$PROJECT_DIR/$CESTA"
  else
   echo "$CESTA"
  fi
}

zkontroluj_help(){
 if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
  ukaz_pouziti
  exit 0
 fi
}

moc_argumentu() {
 if [ "$1" -gt 1 ]; then
  ukaz_pouziti
  chyba "Moc argumentu"
 fi
}

nazev_slozky() {
 if [ "$1" -eq 1 ]; then
  LOG_DIR="$2"
 fi
}

existuje_slozka() {
 if [ !  -d "$1" ]; then
  chyba "Slozka s logy neexistuje: $1"
 fi
}

kontrola_logu() {
 for SOUBOR in "$1"/*.log; do
 TOTAL_COUNT=$((TOTAL_COUNT + 1 ))
  echo "======== $SOUBOR ========="
  if  "$SCRIPT_DIR/kontrola-logu.sh" "$SOUBOR"; then
   echo "VYSLEDEK: OK"
  else
   echo "VYSLEDEK: PROBLEM"
   PROBLEM_COUNT=$((PROBLEM_COUNT + 1 ))
  fi
  echo
 done
}

spocitej_souhrn() {
 if [ "$1" -eq 0 ]; then
  echo "Nenalezen zadny log soubor"
  exit 1
 fi
}

souhrn_problemu() {
echo "Pocet problemovych logu: $1"
echo "Pocet zkontrolovanych logu: $2"
}

souhrn_erroru(){
 if [ "$1" -gt 0 ]; then
  exit 1
 else
  exit 0
 fi
}

ukaz_pouziti() {
 echo "Pouziti: ./skripts/kontrola-vsech-logu.sh [SLOZKA_S_LOGY]"
 echo "Priklad: ./skripts/kontrola-vsech-logu.sh logs"
}

chyba() {
 echo "CHYBA: $1"
 exit 1
}

main(){

echo "Kontroluji vsechny logy"

zkontroluj_help "$1"

moc_argumentu "$#"

nazev_slozky "$#" "$1"

LOG_DIR=$(kontrola_cesty "$LOG_DIR")

existuje_slozka "$LOG_DIR"

PROBLEM_COUNT=0
TOTAL_COUNT=0

shopt -s nullglob

kontrola_logu "$LOG_DIR"

spocitej_souhrn "$TOTAL_COUNT"

souhrn_problemu "$PROBLEM_COUNT" "$TOTAL_COUNT"

souhrn_erroru "$PROBLEM_COUNT"
}

main "$@"
