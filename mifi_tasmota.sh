#! /bin/sh

GET='wget -q -O-'
MIFI_HOST='192.168.1.1'
BATTERY_MIN='30'
BATTERY_MAX='95'
PLUG_HOST='tasmota-9E7DC0-7616'

status_json=$(${GET} "http://${MIFI_HOST}/srv/status")
battery=$(echo "${status_json}" | sed -ne 's/.*,"statusBarBatteryPercent":"\([0-9]*\)",.*/\1/p')
charging=$(echo "${status_json}" | sed -ne 's/.*,"statusBarBatteryChargingSource":"\([^"]*\)",.*/\1/p')

echo "$(date '+%Y-%m-%d %H:%M:%S') : ${battery} ${charging}"
if [ "${battery}" -le "${BATTERY_MIN}" -a "${charging}" = "ChargingSourceNone" ] ; then
	r=$(${GET} "http://${PLUG_HOST}/cm?cmnd=Power%20on")
	echo "Enable: ${GET} 'http://${PLUG_HOST}/cm?cmnd=Power%20on' => ${r}"
elif [ "${battery}" -ge "${BATTERY_MAX}" -a "${charging}" != "ChargingSourceNone" ] ; then
	r=$(${GET} "http://${PLUG_HOST}/cm?cmnd=Power%20off")
	echo "Disable: ${GET} 'http://${PLUG_HOST}/cm?cmnd=Power%20off' => ${r}"
fi
