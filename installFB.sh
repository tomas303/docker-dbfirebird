#!/bin/bash

# installation problem reported by firebird install script
ln -s /sbin/nologin /bin/nologin

# get and silent installation of FB3
cd $INSTALL_DIR
wget https://github.com/FirebirdSQL/firebird/releases/download/R3_0_4/Firebird-3.0.4.33054-0.amd64.tar.gz
tar -xzf Firebird-3.0.4.33054-0.amd64.tar.gz
cd Firebird-3.0.4.33054-0.amd64
./install.sh -silent

# get generated password (: in expr is bash regular expression match)
FBPWD=$(expr $(grep "ISC_PASSWORD=" $FB_DIR/SYSDBA.password) : '.*=\(.*\)')
# change generated password to standard one
$FB_DIR/bin/isql -u SYSDBA -p $FBPWD employee <<< "alter user SYSDBA password 'masterkey';commit;quit;"

# switch on possibility to open database on shared disk
# this is for testing purpose only and is not recommended for production use
# see this option remark in conf file
sed -i 's/#RemoteFileOpenAbility = 0/#just for test purposes\nRemoteFileOpenAbility = 1/' $FB_DIR/firebird.conf
