# Linux Bash Log Automation Project

Small Linux/Bash portfolio project for log checking, report generation, cron automation and basic service troubleshooting.

## What it shows

* Bash scripting
* Linux terminal basics
* working with logs
* "ERROR" / "WARN" detection
* exit codes
* cron automation
* basic "systemctl" / "journalctl"
* simple troubleshooting workflow

## Scripts

bash
./scripts/kontrola-logu.sh logs/app.log
./scripts/kontrola-vsech-logu.sh logs
./scripts/vytvor-report.sh logs
./scripts/posledni-report.sh reports
./scripts/uklid-reporty.sh reports 7

## Service check

bash
./cron/service-test.sh cron

Used for basic service status checks and reading service logs.

## Cron example

cron
0 * * * * cd /path/to/project && ./scripts/vytvor-report.sh logs >> cron_logs/report-cron.log 2>&1

## Workflow

text
logs → Bash scripts → reports → cron → service checks → exit codes

## Technologies

Linux, Bash, Cron, systemctl, journalctl, grep, wc, tail, find, Git

---

# CZ verze

# Linux Bash Log Automation Project

Menší Linux/Bash portfolio projekt pro kontrolu logů, generování reportů, cron automatizaci a základní troubleshooting služeb.

## Co ukazuje

* Bash skriptování
* základy Linux terminálu
* práci s logy
* detekci "ERROR" / "WARN"
* exit kódy
* cron automatizaci
* základní práci s "systemctl" / "journalctl"
* jednoduché troubleshooting workflow

## Skripty

bash
./scripts/kontrola-logu.sh logs/app.log
./scripts/kontrola-vsech-logu.sh logs
./scripts/vytvor-report.sh logs
./scripts/posledni-report.sh reports
./scripts/uklid-reporty.sh reports 7

## Kontrola služby

bash
./cron/service-test.sh cron

Slouží pro základní kontrolu stavu služby a čtení logů služby.

## Cron příklad

cron
0 * * * * cd /path/to/project && ./scripts/vytvor-report.sh logs >> cron_logs/report-cron.log 2>&1

## Workflow

text
logy → Bash skripty → reporty → cron → kontrola služeb → exit kódy

## Technologie

Linux, Bash, Cron, systemctl, journalctl, grep, wc, tail, find, Git
