#!/bin/bash

echo "Run wrk tests on QEMU for 500 users in 30 seconds"
wrk -t12 -c500 -d30s http://localhost:8080/
echo "Run wrk tests on QEMU for 5000 users in 30 seconds"
wrk -t12 -c5000 -d30s http://localhost:8080/

echo "Run wrk tests on Firecracker for 500 users in 30 seconds"
wrk -t12 -c500 -d30s http://172.16.0.2
echo "Run wrk tests on Firecracker for 5000 users in 30 seconds"
wrk -t12 -c5000 -d30s http://172.16.0.2

echo "All tests completed."
