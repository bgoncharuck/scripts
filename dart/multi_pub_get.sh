#!/bin/bash

# 1. chmod +x ./multi_pub_get.sh
# 2. ./multi_pub_get.sh
# 3. restart your IDE

recursivePubGet () {
for D in *; do
    if [ -d "${D}" ]; then
        cd "${D}" || exit
        if [[ -f "pubspec.yaml" ]]
        then
            if grep -q 'flutter' "pubspec.yaml"; then
                flutter pub get
            else
                pub get
            fi
        else recursivePubGet
        fi
        cd ../
    fi
done
}

recursivePubGet

