#!/bin/bash
yay -Sy sane brother-dcp1610w cups brscan4 simple-scan-git

sudo brsaneconfig4 -a name="Brother" model="DCP1610W" ip=192.168.0.16
