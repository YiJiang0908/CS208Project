#!/bin/bash
LOG_FILE1="firecracker_output.log"
LOG_FILE2="qemu_output.log"
> "$LOG_FILE1"
> "$LOG_FILE2"
for i in {1..100}
do
    echo "Run #$i" >> "$LOG_FILE1"
    echo "Run #$i" >> "$LOG_FILE2"
    ./osv/scripts/firecracker.py -e '--bootchart /hello' >> "$LOG_FILE1" 2>&1
    echo "--------------------------------------" >> "$LOG_FILE1"
    ./osv/scripts/run.py -e '--bootchart /hello' >> "$LOG_FILE2" 2>&1
    echo "--------------------------------------" >> "$LOG_FILE2"
done

echo "All runs completed. Output saved to $LOG_FILE1 and $LOG_FILE2."
