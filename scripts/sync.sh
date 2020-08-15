#! /usr/local/bin/bash

if [[ "$(uname -s)" =~ Linux ]]; then
  ./scripts/sync.linux.sh
  exit
fi

if [[ "$(uname -s)" =~ Darwin ]]; then
  ./scripts/sync.mac.sh
  exit
fi

echo "Unsupported system: $(uname -s)"
exit 1
