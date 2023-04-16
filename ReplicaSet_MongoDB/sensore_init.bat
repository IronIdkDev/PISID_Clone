@echo off
start "Server S1" /MIN mongod --config \PISID\Sensores\server1\server1.conf
start "Server S2" /MIN mongod --config \PISID\Sensores\server2\server2.conf
start "Server S3" /MIN mongod --config \PISID\Sensores\server3\server3.conf