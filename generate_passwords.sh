#!/bin/sh

MQTT_PASSWD=$(head -3 /dev/urandom | tr -cd '[:alnum:]' | cut -c -32)
INFLUXDB_ADMIN_PASSWD=$(head -3 /dev/urandom | tr -cd '[:alnum:]' | cut -c -32)
INFLUXDB_USER_PASSWD=$(head -3 /dev/urandom | tr -cd '[:alnum:]' | cut -c -32)

printf "InfluxDB admin -> admin:%s\n" "$INFLUXDB_ADMIN_PASSWD"
printf "InfluxDB user -> user:%s\n" "$INFLUXDB_USER_PASSWD"
printf "Mosquitto MQTT client -> mqttclient:%s\n" "$MQTT_PASSWD"
