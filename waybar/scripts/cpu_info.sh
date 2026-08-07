#!/bin/sh
CPU_NAME=$(lscpu | grep 'Model name' | cut -d: -f2 | xargs | awk '{print $1,$2,$3}')
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
echo "${CPU_NAME}: ${CPU_USAGE}%"
