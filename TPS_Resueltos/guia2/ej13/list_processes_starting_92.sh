#!/bin/bash

while true; do
    ./ej13
    ps -e | grep "^ *9"
    echo '=========='
    sleep 0.1
done

