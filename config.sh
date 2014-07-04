#!/bin/bash

if [[ ! -d /config/conf ]]; then
  mkdir -p /config/conf
  if [[ ! -f /config/conf/default.service.xml ]]; then
    cp -rf /usr/local/crashplan/conf/* /config/conf/
  fi
fi
rm -rf /usr/local/crashplan/conf
ln -sf /config/conf /usr/local/crashplan/conf

if [[ ! -d /config/id ]]; then
  mkdir -p /config/id
fi
rm -rf /var/lib/crashplan
ln -sf /config/id /var/lib/crashplan

chown -R nobody:users /config
