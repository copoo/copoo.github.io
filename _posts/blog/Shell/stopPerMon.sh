#!/bin/sh
 ps -ef|grep  PerfMonitor|awk '{print $2}'|xargs kill -9
