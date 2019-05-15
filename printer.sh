#!/bin/bash
yay -Sy sane brother-dcp1610w cups brscan4 simple-scan-git system-config-printer
sudo brsaneconfig4 -a name="Brother" model="DCP1610W" ip=192.168.0.16
sudo systemctl enable org.cups.cupsd.service
sudo systemctl start org.cups.cupsd.service
