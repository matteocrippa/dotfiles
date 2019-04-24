#!/bin/bash

. distro.sh

echo "GPT"

# prepare nvme
sed -e 's/\s*\([\+0-9a-zA-Z]*\).*/\1/' << EOF | sudo gdisk $NVME
  x # expert mode
  z # wipe disk
  y # confirm
  y # confirm
EOF

# prepare nvme
sed -e 's/\s*\([\+0-9a-zA-Z]*\).*/\1/' << EOF | sudo gdisk $SSD
  x # expert mode
  z # wipe disk
  y # confirm
  y # confirm
EOF

# format disk ssd for home
sed -e 's/\s*\([\+0-9a-zA-Z]*\).*/\1/' << EOF | sudo gdisk $SSD
  o # clear the in memory partition table
  y # confirm cleanup
  n # new partition
  1 # partition number 1
    # default - start at beginning of disk
    # 100 MB boot parttion
  8E00 # filesystem type
  w # write the partition table
  y # confirm
EOF

# format disk nvme for swap and root
sed -e 's/\s*\([\+0-9a-zA-Z]*\).*/\1/' << EOF | sudo gdisk $NVME
  o # clear the in memory partition table
  y # confirm cleanup
  n # new partition
  1 # partition number 1
    # default - start at beginning of disk
  +256MB # 100 MB boot parttion
  EF00
  n # new partition
  2 # partion number 2
    # default, start immediately after preceding partition
    # default, extend partition to end of disk
  8E00 # make a partition bootable
  w # write the partition table
  y # confirm
EOF

# force reboot
# reboot
