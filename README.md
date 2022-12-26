# MiFi tools

Currently MiFi M2000.

## mifi\_tasmota.sh

Check the battery from the MiFi status interface and use an (unsecured as written here) Tasmota smart plug to turn the charger on and off. This script is meant to run from cron on OpenWrt using BusyBox.

Every now and then the MiFi web interface dies and needs a reboot even though the networking still works correctly. It probably has a resource leak. When this happens the script starts failing and the power adapter will stop getting toggled.

## tasmotizer

Extras I used to install Tasmota on a Sonoff S31 plug to control the mifi charger.
