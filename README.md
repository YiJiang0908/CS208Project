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

## Set up QEMU
`project_init.sh` script already download vmlinuz, initrd and image for Ubuntu 24.04, use command:  
```
qemu-system-x86_64 -enable-kvm -M microvm \
    -m 1024 -smp 2 \
    -kernel noble-server-cloudimg-amd64-vmlinuz-generic \
    -initrd noble-server-cloudimg-amd64-initrd-generic \
    -append "console=ttyS0 root=/dev/vda1 rw" \
    -device virtio-blk-device,drive=rootfs \
    -drive file=noble-server-cloudimg-amd64.img,format=qcow2,id=rootfs \
    -netdev user,id=net0,hostfwd=tcp::2222-:22,hostfwd=tcp::8080-:80 -device virtio-net-device,netdev=net0 \
    -nographic

```  
to use start and connect to Ubuntu 24.04 on QEMU.

## Set up Firecracker
Run `firecracker.sh`first to download Ubuntu24.04 kernal and set up ssh key. Then run `setfc.sh`, then open another terminal and run `startfc.sh` to start and connect to Ubuntu 24.04 on Firecracker

## Simple server
In our project to test performance between QEMU and Firecracker, we use Nginx to run a simple server, using command:  
```
sudo apt update
sudo apt install dialog apt-utils -y
sudo apt install nginx -y
sudo systemctl start nginx
sudo systemctl enable nginx
```  
to install and start the nginx server
