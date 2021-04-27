# k8s-lab 
Repository of helper scripts and configs for Kubernetes testing and development on Linux.

# KVM
The tooling is geared towards using KVM / virsh as the virtualization mechanism.

# Basic setup
The script assumes an enviroment with the following VMs/domains:
- master1
- worker1
- worker2
- worker3

# Usage
## Start all domains
`$ ./lab.sh start`

## Shutdown all domains
`$ ./lab.sh stop`

## Get the domstate of all domains
`$ ./lab.sh status`

## Return domain names as a shell list 
`$ ./lab.sh get-nodes`

## Execute a command on each node and print results on stdout/stderr
`$ ./lab.sh exec ls -lah`

## Print the snapshots associated with each domain
`$ ./lab.sh list-snapshots`

## Create a snapshot for each domain using the name specified
`$ ./lab.sh create-snapshots initial_snapshot`

## Restore each domain using the specified snapshot name
`$ ./lab.sh restore-snapshots initial_snapshot`

## Delete snapshot for each domain
`$ ./lab.sh delete-snapshots initial_snapshot`

## Validate connectivity to nodes via SSH
`$ ./lab.sh ping`

## Create bash completion rules
`# ./lab.sh bash-completion > /etc/bash_completion.d/lab`
