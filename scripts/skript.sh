#!/bin/bash

if [ $# -ne 2 ]; then
 echo "Pouziti: ./skript.sh JMENO TECHNOLOGIE"
 exit 1
fi

JMENO="$1"
TECHNOLOGIE="$2"

case "$TECHNOLOGIE" in
 docker)
  echo "Vybral jsi Docker"
  ;;
 linux)
  echo "Vybral jsi Linux"
  ;;
 *)
  echo "Neznama technologie: $TECHNOLOGIE"
  exit 1
  ;;
esac

echo Ahoj ze skriptu
echo Dnes se ucim $TECHNOLOGIE
echo Uzivatel je $JMENO
echo Prvni argument je $1
echo Druhy argument je $2
echo Vsechny argumenty jsou $@
echo Pocer argumentu je $#
