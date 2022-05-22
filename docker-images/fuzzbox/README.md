fuzzbox
-------

Docker box for fuzzing with parallel mode AFL

About
-----
This is a docker box with the following:

- LLVM 9
- `AFL`, built from source against LLVM 9
- `afl-utils`
- InfluxDB
- Grafana

Grafana is hooked up to InfluxDB and polls it for information on current
fuzzing jobs.  This information is pushed into InfluxDB by tool that runs under
`afl-cron`. Grafana then serves as the monitoring platform for your
backgrounded AFL jobs.

The intent is to serve as a base box for building fuzzing environments. Start
from this box, add your fuzzing target, and modify the entrypoint to kick off
afl-multicore against your target.
