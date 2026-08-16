#/bin/sh
#   By @aJBboCydia

set -e

rm -rf .theos packages

for SCHEME in rootless roothide; do
    make clean
    make package THEOS_PACKAGE_SCHEME=$SCHEME
done

rm -rf .theos

ls -1 packages/*.deb

DEVICE_ARCH=$(sshpass -p "a" ssh root@localhost dpkg --print-architecture)
DEPLOY_DEB=$(ls -1 packages/*_$DEVICE_ARCH.deb | head -n 1)

sshpass -p "a" ssh root@localhost rm -rf /var/mobile/Documents/theosTweaks/*.deb
sshpass -p "a" scp "$DEPLOY_DEB" root@localhost:/var/mobile/Documents/theosTweaks
sshpass -p "a" ssh root@localhost dpkg -i /var/mobile/Documents/theosTweaks/*.deb
sshpass -p "a" ssh root@localhost killall SpringBoard
