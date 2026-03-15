# MiSTer-iperf3

A script for running [iperf3](https://iperf.fr/) on your MiSTer.

## Prerequisites

* A network connected MiSTer (Ethernet or wifi)
* Optionaly a keyboard connected to your MiSTer for inputting the address of
  your iperf3 server
* iperf3 running in server mode on a computer on your network

## Setup

1. Add the following to `/media/fat/downloader.ini`.

```ini
[davewongillies/mister-iperf3]
db_url = https://raw.githubusercontent.com/davewongillies/MiSTer-iperf3/db/db.json.zip
```

2. Run `update` or `update_all` from the Scripts menu.

## Additional Setup

If you don't want to input the address of your iperf3 server again, create a file
named `config` in the directory `/media/fat/Scripts/.config/mister-iperf3` and
put the following into it:

```ini
IPERF3_SERVER=<address of your iperf3 server here>
```

## Running iperf3

1. Run iperf3 in server mode on another computer, eg: `iperf3 --server --one-off`
2. On your MiSTer run `iperf3` from the `Scripts` menu

iperf3 output is logged to `/var/log/iperf3.log` on your MiSTer.

## Example output

```
Connecting to host 192.168.1.115, port 5201
[  5] local 192.168.1.17 port 45454 connected to 192.168.1.115 port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec  63.2 MBytes   529 Mbits/sec    0    198 KBytes
[  5]   1.00-2.00   sec  63.1 MBytes   530 Mbits/sec    0    198 KBytes
[  5]   2.00-3.00   sec  63.4 MBytes   532 Mbits/sec    0    198 KBytes
[  5]   3.00-4.00   sec  59.6 MBytes   500 Mbits/sec    0    208 KBytes
[  5]   4.00-5.00   sec  63.2 MBytes   531 Mbits/sec    0    221 KBytes
[  5]   5.00-6.00   sec  63.9 MBytes   536 Mbits/sec    0    221 KBytes
[  5]   6.00-7.00   sec  63.5 MBytes   532 Mbits/sec    0    221 KBytes
[  5]   7.00-8.00   sec  64.2 MBytes   539 Mbits/sec    0    247 KBytes
[  5]   8.00-9.00   sec  62.8 MBytes   526 Mbits/sec    0    313 KBytes
[  5]   9.00-10.00  sec  63.2 MBytes   530 Mbits/sec    0    313 KBytes
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.00  sec   630 MBytes   529 Mbits/sec    0            sender
[  5]   0.00-10.01  sec   630 MBytes   528 Mbits/sec                  receiver
```
