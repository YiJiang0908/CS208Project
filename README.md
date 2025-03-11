# CS 208 Project  
Understanding Firecracker in Cloud-Based Applications  
Elisa Zhang xzhan550@ucr.edu  
Yi Jiang yjian221@ucr.edu  

## Motivation
This research helps identify scenarios where Firecracker outperforms traditional VMs, reducing startup time and resource overhead. It has applications in serverless computing, microservices, and edge computing environments.

## Tools
In our project we use QEMU, Firecracker, KVM, and OSv to test performance of Firecracker. Also we use Nginx and wrk to test using Firecracker as a web server.

## Experimental Setup
Using c6220 at APT Cluster on CloudLab, the node has Intel Xeon Processor E5-2650 v2@2.6GHz with 8 cores and 64GB of RAM, running Ubuntu 20.04 system.  
To run our project, run script `project_init.sh` to download Docker, QEMU, KVM, Firecracker, OSv, and wrk.

## QEMU
```
qemu-system-x86_64 -enable-kvm -M microvm \
    -m 1024 -smp 2 \
    -kernel noble-server-cloudimg-amd64-vmlinuz-generic \
    -initrd noble-server-cloudimg-amd64-initrd-generic \
    -append "console=ttyS0 root=/dev/vda1 rw init=/bin/bash" \
    -device virtio-blk-device,drive=rootfs \
    -drive file=noble-server-cloudimg-amd64.img,format=qcow2,id=rootfs \
    -netdev user,id=net0,hostfwd=tcp::2222-:22 -device virtio-net-device,netdev=net0 \
    -nographic

```