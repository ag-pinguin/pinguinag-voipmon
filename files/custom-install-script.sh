#!/bin/bash

SHAREDIR=usr/local/share/voipmonitor
AUDIODIR=$SHAREDIR/audio
BINDIR=usr/local/sbin
CFGDIR=etc
INITDIR=$CFGDIR/init.d
SENSOR=voipmonitor
SPOOLDIR=/var/spool/$SENSOR

if [ "a$1" == "a--uninstall" ]
then

	echo "Uninstalling /$SHAREDIR"
	rm -rf /$SHAREDIR

	echo "Uninstalling $SENSOR binary from /$BINDIR/$SENSOR"
	rm /$BINDIR/$SENSOR

	echo "Moving /$CFGDIR/$SENSOR.conf to /$CFGDIR/$SENSOR.conf-backup."
	mv /$CFGDIR/$SENSOR.conf /$CFGDIR/$SENSOR.conf-backup

	echo "Deleting $SPOOLDIR"
	rm -rf $SPOOLDIR

	update-rc.d $SENSOR remove &>/dev/null
	chkconfig $SENSOR off &>/dev/null
	chkconfig --del $SENSOR &>/dev/null

	echo "Deleting starting script /$INITDIR/$SENSOR"
	rm /$INITDIR/$SENSOR

	echo;
	echo "The database is not deleted. Do it manually.";
	echo;
	exit 0;
fi

echo "Installing /$AUDIODIR"
mkdir -p /$AUDIODIR
cp $AUDIODIR/* /$AUDIODIR/

echo "Installing $SENSOR binary to /$BINDIR/$SENSOR"
mkdir -p /$BINDIR
cp $BINDIR/$SENSOR /$BINDIR/$SENSOR

echo "Creating $SPOOLDIR"
mkdir $SPOOLDIR

echo;
echo "Create database $SENSOR with this command: mysqladmin create $SENSOR";
echo "Edit /$CFGDIR/$SENSOR.conf";
echo "Run $SENSOR /$INITDIR/$SENSOR start";
echo;
