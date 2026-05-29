#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

REPORT_DIR="$PROJECT_DIR/reports"
DAY=1
MINUTES=$((DAY * 1440))
CAS="24 hodin"

chyba(){
 echo "CHYBA: $1"
 exit
}

existuje_slozka() {
 if [ ! -d "$1" ]; then
  chyba "Slozka s reporty neexistuje: $1"
  exit 1
 fi
}

najdi_stare_reporty(){
 find "$1" -type f -name "*.txt" -mmin +"$2"
}

uklid_reportu(){
 if [ "$1" -eq 0 ]; then
  echo "Zadne stare reporty k uklidu"
  exit 0
 fi
}

smaz_stare_reporty(){
find "$1" -type f -name "*.txt" -mmin +"$2" -delete
} 
echo "uklid starych reportu"
echo "slozka s reporty: $REPORT_DIR"
echo "mazu reporty starsi nez $MINUTES minut - $CAS"

existuje_slozka "$REPORT_DIR"

echo "Stare reporty na smazani:"
najdi_stare_reporty "$REPORT_DIR" "$MINUTES"

POCET=$(najdi_stare_reporty "$REPORT_DIR" "$MINUTES" | wc -l)
echo "Pocet reportu ke smazani: $POCET"

uklid_reportu "$POCET"

smaz_stare_reporty "$REPORT_DIR" "$MINUTES"
echo "Stare reporty smazany"
