# Linux Bash Log Automation Project

Small Linux/Bash portfolio project focused on log checks, report generation, cron automation and basic service troubleshooting.

## What it shows

* Bash scripting
* Linux terminal basics
* working with logs
* `ERROR` / `WARN` detection
* exit codes
* cron automation
* basic `systemctl` / `journalctl`
* simple troubleshooting workflow

## Scripts

```bash
./scripts/kontrola-logu.sh logs/app.log
./scripts/kontrola-vsech-logu.sh logs
./scripts/vytvor-report.sh logs
./scripts/posledni-report.sh reports
./scripts/uklid-reporty.sh
```

## Service check

```bash
./cron/service-test.sh cron
./cron/service-test.sh cron ssh docker
```

Used for checking whether a service exists, is active, is enabled after boot and for reading recent service logs.

## Cron example

```cron
0 * * * * cd /path/to/project && ./scripts/vytvor-report.sh logs >> cron_logs/report-cron.log 2>&1
```

## Workflow

```text
logs → Bash scripts → reports → cron → service checks → exit codes
```

## Technologies

Linux, Bash, Cron, systemctl, journalctl, grep, wc, tail, find, Git

---

# CZ verze

# Linux Bash Log Automation Project

Menší Linux/Bash portfolio projekt zaměřený na kontrolu logů, generování reportů, cron automatizaci a základní troubleshooting služeb.

## Co ukazuje

* Bash skriptování
* základy Linux terminálu
* práci s logy
* detekci `ERROR` / `WARN`
* exit kódy
* cron automatizaci
* základní práci se `systemctl` / `journalctl`
* jednoduché troubleshooting workflow

## Skripty

```bash
./scripts/kontrola-logu.sh logs/app.log
./scripts/kontrola-vsech-logu.sh logs
./scripts/vytvor-report.sh logs
./scripts/posledni-report.sh reports
./scripts/uklid-reporty.sh
```

## Kontrola služby

```bash
./cron/service-test.sh cron
./cron/service-test.sh cron ssh docker
```

Slouží ke kontrole, jestli služba existuje, běží, je povolená po startu systému a k vypsání posledních logů služby.

## Cron příklad

```cron
0 * * * * cd /path/to/project && ./scripts/vytvor-report.sh logs >> cron_logs/report-cron.log 2>&1
```

## Workflow

```text
logy → Bash skripty → reporty → cron → kontrola služeb → exit kódy
```

## Technologie

Linux, Bash, Cron, systemctl, journalctl, grep, wc, tail, find, Git

