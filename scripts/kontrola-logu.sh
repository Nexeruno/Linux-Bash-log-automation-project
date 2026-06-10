#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

LOG="$1"

zkontroluj_help() {
 if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
  ukaz_pouziti
  exit 0
 fi
}

kontrola_argumentu(){
 if [ "$1" -ne 1 ]; then
  ukaz_pouziti
  chyba "Spatny pocet argumentu"
 fi
}


kontrola_souboru(){
 if ! existuje_soubor "$1"; then
  chyba "Soubor neexistuje: $1"
 fi
}

ukaz_pouziti() {
 echo "Pouziti: ./skripts/kontrola-logu.sh [SOUBOR_LOGU]"
 echo "Priklad: ./skripts/kontrola-logu.sh logs/app.log"
}

chyba() {
 echo "CHYBA: $1"
 exit 1
}

existuje_soubor() {
 [ -f "$1" ]
}

spocitej_vyskyt() {
 grep -c "$1" "$2"
}

vypis_problemove_radky() {
 echo "Problemove radky:"
 grep -n -E "ERROR|WARN" "$1"
}

vypis_souhrn() {
 echo "Pocet ERROR: $1"
 echo "Pocet WARN: $2"
 echo "Celkovy pocet radku je $3"
}

vypis_nejcastejsi_problemy() {
 echo "Nejcastejsi problémy:"
 grep -E "ERROR|WARN" "$1" | sort | uniq -c | sort -nr
}

vyhodnot_stav_ERROR_logu() {
 if [ "$1" -gt 0 ]; then
  echo "STAV: Log obsahuje chyby"
  chyba "Log obsahuje ERROR: $2"
 else
  echo "STAV: Log je bez chyb"
 fi
}

vyhodnot_stav_WARN_logu() {
 if [ "$1" -gt 0 ]; then
  echo "UPOZORNENI: $2 obsahuje varovani"
 fi
}

main() {
echo "Kontrola logu"

zkontroluj_help "$1"

kontrola_argumentu "$#"

LOG=$(kontrola_cesty "$1")

kontrola_souboru "$LOG"

echo "Soubor logu je: $LOG"

ERROR_COUNT=$(spocitej_vyskyt "ERROR" "$LOG")

WARN_COUNT=$(spocitej_vyskyt "WARN" "$LOG")

RADKY=$(wc -l < "$LOG")

vypis_souhrn "$ERROR_COUNT" "$WARN_COUNT" "$RADKY"

vypis_nejcastejsi_problemy "$LOG"

vypis_problemove_radky "$LOG"

vyhodnot_stav_WARN_logu "$WARN_COUNT" "$LOG"

vyhodnot_stav_ERROR_logu "$ERROR_COUNT" "$LOG"
}

main "$@"

