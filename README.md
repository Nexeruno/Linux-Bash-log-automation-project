# Linux Bash Log Automation

A small Linux/Bash automation project for checking log files, generating reports, reading the latest report, cleaning old reports, and running the workflow automatically with cron.

This project was built as a practical Linux/Bash learning project focused on automation, log processing, exit codes, cron jobs, and clean script structure.

## Features

* Check a single log file
* Check all log files in a selected directory
* Count `ERROR` and `WARN` occurrences
* Print problematic log lines
* Generate timestamped reports
* Read the latest generated report
* Clean old reports automatically
* Run report generation with cron
* Log cron output into a separate cron log file
* Use clean Bash structure with functions and `main()`

## Project Structure

```text
linux-cviceni/
├── logs/
│   ├── app.log
│   └── clean.log
├── reports/
├── cron_logs/
└── skripts/
    ├── kontrola-logu.sh
    ├── kontrola-vsech-logu.sh
    ├── vytvor-report.sh
    ├── posledni-report.sh
    └── uklid-reporty.sh
```

## Scripts

### `kontrola-logu.sh`

Checks one specific log file.

```bash
./skripts/kontrola-logu.sh logs/app.log
```

The script checks if the file exists, counts `ERROR` and `WARN` entries, prints problematic lines, and returns a proper exit code.

```text
0 = log is OK
1 = log contains an error or the script failed
```

### `kontrola-vsech-logu.sh`

Checks all `.log` files inside a selected directory.

```bash
./skripts/kontrola-vsech-logu.sh logs
```

It runs `kontrola-logu.sh` for every log file and prints a summary.

### `vytvor-report.sh`

Creates a timestamped report from the log check.

```bash
./skripts/vytvor-report.sh logs
```

Reports are saved into the `reports/` directory.

### `posledni-report.sh`

Displays the latest generated report.

```bash
./skripts/posledni-report.sh
```

### `uklid-reporty.sh`

Cleans old reports from the `reports/` directory.

```bash
./skripts/uklid-reporty.sh
```

The cleanup script removes reports older than the configured time limit.

## Cron Automation

The project can be automated with cron.

Example: generate a report every hour:

```bash
0 * * * * mkdir -p /root/linux-cviceni/cron_logs && cd /root/linux-cviceni && ./skripts/vytvor-report.sh logs >> /root/linux-cviceni/cron_logs/report-cron.log 2>&1
```

Example: clean old reports every day at 18:00:

```bash
0 18 * * * mkdir -p /root/linux-cviceni/cron_logs && cd /root/linux-cviceni && ./skripts/uklid-reporty.sh >> /root/linux-cviceni/cron_logs/cleanup-cron.log 2>&1
```

## What I Practiced

* Linux terminal basics
* Bash scripting
* Bash functions
* `main()` structure
* Script arguments: `$1`, `$#`, `$@`
* Exit codes: `0` and `1`
* `return` vs `exit`
* File and directory checks with `-f` and `-d`
* Empty variable checks with `-z`
* `grep`, `find`, `sort`, `uniq`, `wc`, `head`, `tail`
* `tee` and `PIPESTATUS`
* Relative and absolute paths
* `SCRIPT_DIR` and `PROJECT_DIR`
* Cron jobs
* Redirecting output with `>>`
* Redirecting errors with `2>&1`
* Basic automation workflow

## Example Workflow

```text
1. Log files are stored in logs/
2. Bash scripts check the logs
3. Reports are generated into reports/
4. Cron runs the report script every hour
5. Cron output is saved into cron_logs/
6. Old reports are cleaned automatically once per day
```

## Goal of the Project

The main goal of this project is to build a practical foundation for Linux automation, DevOps, monitoring, and future MLOps learning.

This project is part of my learning path toward:

* Linux
* Bash automation
* DevOps
* Monitoring
* Infrastructure automation
* MLOps / AI infrastructure

______________________________________________________________________________________________________________________

# Linux Bash Log Automation CZ

Malý Linux/Bash automatizační projekt pro kontrolu log souborů, generování reportů, čtení posledního reportu, úklid starých reportů a automatické spouštění přes cron.

Projekt vznikl jako praktické cvičení Linuxu a Bashe se zaměřením na automatizaci, zpracování logů, návratové kódy, cron úlohy a čistší strukturu skriptů.

## Co projekt umí

* kontrola jednoho log souboru
* kontrola všech logů ve vybrané složce
* počítání výskytů `ERROR` a `WARN`
* výpis problémových řádků
* vytváření reportů s časem
* zobrazení posledního reportu
* mazání starých reportů
* automatické spouštění přes cron
* ukládání výstupu cronu do samostatných logů
* použití funkcí a `main()` pro čistší strukturu Bash skriptů

## Struktura projektu

```text
linux-cviceni/
├── logs/
│   ├── app.log
│   └── clean.log
├── reports/
├── cron_logs/
└── skripts/
    ├── kontrola-logu.sh
    ├── kontrola-vsech-logu.sh
    ├── vytvor-report.sh
    ├── posledni-report.sh
    └── uklid-reporty.sh
```

## Skripty

### `kontrola-logu.sh`

Kontroluje jeden konkrétní log soubor.

```bash
./skripts/kontrola-logu.sh logs/app.log
```

Skript ověří, že soubor existuje, spočítá `ERROR` a `WARN`, vypíše problémové řádky a vrátí správný návratový kód.

```text
0 = log je v pořádku
1 = log obsahuje chybu nebo skript selhal
```

### `kontrola-vsech-logu.sh`

Kontroluje všechny `.log` soubory ve vybrané složce.

```bash
./skripts/kontrola-vsech-logu.sh logs
```

Skript postupně spouští `kontrola-logu.sh` nad každým logem a vypíše souhrn.

### `vytvor-report.sh`

Vytvoří report kontroly logů s časem v názvu.

```bash
./skripts/vytvor-report.sh logs
```

Reporty se ukládají do složky `reports/`.

### `posledni-report.sh`

Zobrazí poslední vytvořený report.

```bash
./skripts/posledni-report.sh
```

### `uklid-reporty.sh`

Maže staré reporty ze složky `reports/`.

```bash
./skripts/uklid-reporty.sh
```

Skript maže reporty starší než nastavený časový limit.

## Automatizace přes cron

Projekt je možné automatizovat pomocí cronu.

Příklad: vytvoření reportu každou hodinu:

```bash
0 * * * * mkdir -p /root/linux-cviceni/cron_logs && cd /root/linux-cviceni && ./skripts/vytvor-report.sh logs >> /root/linux-cviceni/cron_logs/report-cron.log 2>&1
```

Příklad: úklid starých reportů každý den v 18:00:

```bash
0 18 * * * mkdir -p /root/linux-cviceni/cron_logs && cd /root/linux-cviceni && ./skripts/uklid-reporty.sh >> /root/linux-cviceni/cron_logs/cleanup-cron.log 2>&1
```

## Co jsem si procvičil

* základy Linux terminálu
* Bash skriptování
* Bash funkce
* strukturu přes `main()`
* argumenty skriptů: `$1`, `$#`, `$@`
* návratové kódy `0` a `1`
* rozdíl mezi `return` a `exit`
* kontrolu souborů a složek pomocí `-f` a `-d`
* kontrolu prázdné proměnné pomocí `-z`
* příkazy `grep`, `find`, `sort`, `uniq`, `wc`, `head`, `tail`
* `tee` a `PIPESTATUS`
* relativní a absolutní cesty
* `SCRIPT_DIR` a `PROJECT_DIR`
* cron úlohy
* přesměrování výstupu přes `>>`
* přesměrování chyb přes `2>&1`
* základní automatizační workflow

## Příklad workflow

```text
1. Log soubory jsou uložené ve složce logs/
2. Bash skripty logy zkontrolují
3. Reporty se uloží do složky reports/
4. Cron spouští reportovací skript každou hodinu
5. Výstup cronu se ukládá do cron_logs/
6. Staré reporty se jednou denně automaticky mažou
```

## Cíl projektu

Cílem projektu je vybudovat praktický základ pro Linux automatizaci, DevOps, monitoring a později MLOps.

Projekt je součástí mé učicí cesty směrem k:

* Linuxu
* Bash automatizaci
* DevOps
* monitoringu
* infrastrukturní automatizaci
* MLOps / AI infrastruktuře

