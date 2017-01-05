#!/bin/bash

function mount_disks() {
	HDDEVS=`ls /dev/sd*`
	for hd in $HDDEVS
	do
		label=`sudo e2label $hd`
		if [ -n "$label" ];then
			DIR=`echo $label | tr '[:upper:]' '[:lower:]'`
			MNT=/home/$DIR
			if [ -d $MNT ]; then
				mounted_info=`mount | grep $hd`
				if [ -n "$mounted_info" ];then
					sudo umount $hd
				fi
				sudo mount $hd $MNT
			fi
		fi
	done

	if [ -d "/home/misc/docs/usb-docs" ]
	then
		rm ~/Desktop/usb-docs
		ln -s /home/misc/docs/usb-docs ~/Desktop/usb-docs
	fi
}

function umount_disks() {
	mounted_disks=`mount | grep "/dev/sd" | awk '{print $1}'`
	for disk in $mounted_disks
	do
		echo "Try to umount $disk ...."
		sudo umount $disk
	done
}
