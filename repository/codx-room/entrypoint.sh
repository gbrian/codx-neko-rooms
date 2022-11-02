#!/bin/bash
codx clone-clinic
# Run supervisor
/usr/bin/supervisord -c /etc/neko/supervisord.conf