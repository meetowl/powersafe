#!/bin/bash
# Installer script for powersafe

if ! systemctl --version >> /dev/null; then
	echo "This script has only been written for systemd." >> /dev/stderr
	echo "Please submit a bug report requesting for other init systems." >> /dev/stderr
	exit 0
fi

if ! ip -V >> /dev/null; then
	echo "This script has only been written for iproute2." >> /dev/stderr
	echo "Please submit a bug report requesting for other network systems." >> /dev/stderr
fi

if [ $EUID -ne 0 ]; then
    echo "Not running as root, exiting."  >> /dev/stderr
    exit 1;
fi

echo "Installing powersafe as root..."

if ! cp ./powersafe /sbin/powersafe ; then
	echo "error: copying powersafe failed."
	exit 1
fi
chmod +x /sbin/powersafe

if ! cp ./systemd/powersafe.{"service","timer"} /etc/systemd/system; then
	echo "error: copying systemd services failed."
	rm -f /sbin/powersafe
	exit 1
fi

printf "Interface to check state for:"
read netinterface
while ! /sbin/powersafe set-interface $netinterface; do
	printf "Interface to check state for:"
	read netinterface
done

systemctl daemon-reload

echo "Powersafe has been installed."
echo "Run \"systemctl start powersafe.timer\" to start periodic checking."

exit 0
