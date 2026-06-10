#!/bin/bash

CAS=$(date "+%d-%m-%Y %H-%M-%S")

SERVICE="$1"

zkontroluj(){
 if [ "$1" -lt 1 ]; then
  ukaz_pouziti
  exit 1
 fi
}

kontrola_casu(){
 echo "Cas kontroly: $1"
 echo
}

vypis_logy_sluzby(){
 echo "Posledni logy sluzby $1:"
 journalctl -u "$1" -n 5 --no-pager
}

celkovy_stav(){
 if [ "$1" -eq 0 ]; then
  echo "CELKOVY STAV: OK"
 else
  echo "CELKOVY STAV: PROBLEM"
 fi
}

chyba(){
 echo "CHYBA: $1"
 exit 1
}

zkontroluj_help(){
 if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
  ukaz_pouziti
  exit 0
 fi
}

ukaz_pouziti(){
 echo "Pouziti: ./service-test.sh NAZEV_SLUZBY"
 echo "Priklad: ./service-test.sh cron"
 echo "Priklad: ./service-test.sh cron ssh docker"
}

sluzba_bezi(){
 systemctl is-active --quiet "$1"
}

sluzba_povolena(){
 systemctl is-enabled --quiet "$1"
}

sluzba_existuje(){
 systemctl cat "$1" >/dev/null 2>&1
}

bezi_sluzba(){
 if sluzba_bezi "$1"; then
  echo "Sluzba $1 bezi"
 else
  echo "Sluzba $1 nebezi"
  vypis_logy_sluzby "$1"
  STAV=1
 fi
}

povolena_sluzba(){
 if sluzba_povolena "$1"; then
  echo "Sluzba $1 je povolena po startu"
 else
  echo "Sluzba $1 neni povolena po startu"
  STAV=1
 fi
}

for_cyklus(){
 local STAV=0
  for SERVICE in "$@"; do
   echo "Kontroluji sluzbu: $SERVICE"
   if ! sluzba_existuje "$SERVICE"; then
      echo "Sluzba $SERVICE neexistuje"
      STAV=1
      echo
      continue
    fi

   bezi_sluzba "$SERVICE"
   povolena_sluzba "$SERVICE"
   echo
done
return "$STAV"
}
main(){

zkontroluj_help "$1"

zkontroluj "$#"

kontrola_casu "$CAS"

SERVICE="$1"
STAV=0

bezi_sluzba "$SERVICE"

povolena_sluzba "$SERVICE"

sluzba_bezi "$SERVICE"

sluzba_povolena "$SERVICE"

sluzba_existuje "$SERVICE"

for_cyklus "$@"
STAV=$?

celkovy_stav "$STAV"

exit "$STAV"
}

main "$@"
