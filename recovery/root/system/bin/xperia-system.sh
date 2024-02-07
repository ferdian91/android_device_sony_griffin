#!/sbin/sh

# set global device name for Xperia 1 & 5
# because developers use that device name for custom Rom

SCRIPTNAME="xperia"

finish()
{
	echo "Script complete."
	exit 0
}

check_resetprop()
{
	if [ -e /system/bin/resetprop ] || [ -e /sbin/resetprop ]; then
		echo "Resetprop binary found!"
		setprop_bin=resetprop
	else
		echo "Resetprop binary not found. Falling back to setprop."
		setprop_bin=setprop
	fi
}

temp_mount()
{
	is_mounted=$(ls -A "$1" 2>/dev/null)
	if [ -n "$is_mounted" ]; then
		echo "$2 already mounted."
	else
		mkdir -p "$1"
		if [ -d "$1" ]; then
			echo "Temporary $2 folder created at $1."
		else
			echo "Unable to create temporary $2 folder."
			finish_error
		fi
		mount -t ext4 -o ro "$3" "$1"
		is_mounted=$(ls -A "$1" 2>/dev/null)
		if [ -n "$is_mounted" ]; then
			echo "$2 mounted at $1."
			$setprop_bin $SCRIPTNAME."$2"_mounted 1
			echo "$SCRIPTNAME.$2_mounted=$(getprop "$SCRIPTNAME"."$2"_mounted)"
		else
			echo "Unable to mount $2 to temporary folder."
			finish_error
		fi
	fi
}

unmount_system()
{
	is_system_mounted=$(getprop $SCRIPTNAME.system_mounted)
	if [ "$is_system_mounted" = 1 ]; then
		umount "$TEMPSYS"
		$setprop_bin $SCRIPTNAME.system_mounted 0
		rmdir "$TEMPSYS"
	fi
}

ab_device=$(getprop ro.build.ab_update)
sdkver=$(getprop ro.build.version.sdk)
if [ -n "$ab_device" ]; then
	echo "A/B device detected! Finding current boot slot..."
	suffix=$(getprop ro.boot.slot_suffix)
	if [ -z "$suffix" ]; then
		suf=$(getprop ro.boot.slot)
		if [ -n "$suf" ]; then
			suffix="_$suf"
		fi
	fi
	echo "Current boot slot: $suffix"
fi
if [ "$sdkver" -ge 26 ]; then
	if [ -z "$setprop_bin" ]; then
		check_resetprop
	fi
fi

echo "Getting data from boot.img"
prod=$(getprop ro.build.product)
echo "Current build product name $prod"
dev=$(getprop ro.product.device)
echo "Current product device name $dev"

BUILDPROP="system/build.prop"
TEMPSYS="/s"
syspath="/dev/block/bootdevice/by-name/system$suffix"

temp_mount "$TEMPSYS" "system" "$syspath"
if [ -f "$TEMPSYS/$BUILDPROP" ]; then
	echo "Reading system properties from build.prop..."
	models=$(grep -i 'ro.build.product=' /s/system/build.prop  | cut -f2 -d'=')
	unmount_system
	echo "Current system from build.prop: $models"
	if [ "$models" == "J8110" ] || [ "$models" == "J8170" ] || [ "$models" == "J9110" ] || [ "$models" == "J9150" ] || [ "$models" == "J9180" ] || [ "$models" == "SO-03L" ] || [ "$models" == "SOV40" ] || [ "$models" == "802SO" ]; then
		$setprop_bin ro.build.product J9110
		$setprop_bin ro.product.device J9110
		echo "changed the device name to J9110"
        finish
	elif [ "$models" == "J8210" ] || [ "$models" == "J8270" ] || [ "$models" == "J9210" ] || [ "$models" == "J9260" ] || [ "$models" == "SO-01M" ] || [ "$models" == "SOV41" ] || [ "$models" == "901SO" ]; then
	    $setprop_bin ro.build.product J9210
	    $setprop_bin ro.product.device J9210
	    echo "changed the device name to J9210"
        finish
    else
		echo "your device is not XPERIA 1 & 5"
		finish
	fi
fi

finish
