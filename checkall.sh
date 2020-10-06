#!/bin/bash

if [ ! -f "/etc/config/cache-md5/md5.txt" ]; then
    touch /etc/config/cache-md5/md5.txt
fi
old_md5=`cat /etc/config/cache-md5/md5.txt`

if [ -z $old_md5 ]
then
    md5sum /etc/config/zone.yml | cut -d" " -f1 > /etc/config/cache-md5/md5.txt
else
    new_md5=`md5sum /etc/config/zone.yml | cut -d" " -f1`
    if [ "$old_md5" != "$new_md5" ]
    then
        echo $new_md5 > /etc/config/cache-md5/md5.txt
        pdns_control reload
    fi
fi

_result=`dig  @127.0.0.1 txt test-local.play-rbcdn.ais.co.th +short`
if [ "$_result" == "\"success\"" ]
then
    echo "check dns success."
    exit 0
else
    echo "check dns error."
    exit 1
fi
