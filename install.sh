#!/bin/sh
(echo '#!'`which python3`; cat kubesible) > /usr/local/bin/kubesible
sudo chmod 755 /usr/local/bin/kubesible
pip3 install -r requirement.txt
