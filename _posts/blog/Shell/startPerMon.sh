#!/bin/sh
nohup sh PerfMonitor_CPU.sh &
nohup sh PerfMonitor_Swap.sh &
nohup sh PerfMonitor_Mem.sh &
nohup sh PerfMonitor_LA.sh &
nohup sh PerfMonitor_Eth0.sh eth0 1 &
