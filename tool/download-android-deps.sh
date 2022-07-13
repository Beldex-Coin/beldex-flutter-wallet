#!/bin/bash

if [ "$#" -ne 1 ] || [[ "$1" != http* ]]; then
    echo "Usage: $0 URL -- download and extract an beldex-core android-deps package (typically from https://beldex.rocks)" >&2
    exit 1
fi

if ! [ -d beldex_coin/ios/External/android/beldex ]; then
    echo "This script needs to be invoked from the beldex-wallet top-level project directory" >&2
    exit 1
fi

curl -sS "$1" | tar --strip-components=1 -C beldex_coin/ios/External/android/beldex/ -xJv
