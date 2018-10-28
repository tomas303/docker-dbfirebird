#!/bin/bash
docker create -p 3050:3050 -v /mnt/datasharetwo:/datasharetwo --name dbfirebird tomas303/databases:dbfirebird303

