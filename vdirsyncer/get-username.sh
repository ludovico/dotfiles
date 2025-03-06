#!/bin/bash
pass vdirsyncer-nextcloud | head -n2 | tail -n1 | sed -e 's/Username: //'
