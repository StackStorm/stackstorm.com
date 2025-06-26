#!/bin/bash

BRANCH="v3.8"
URL="https://raw.githubusercontent.com/StackStorm/st2-packages/$BRANCH/scripts/st2_bootstrap.sh"
TIMEOUT=5

cat <<EOF


Warning: Outdated URL for StackStorm install script.

You have used a retired URL to reach install.sh!

Provide the version vX.X in the URL path to install StackStorm.

   https://stackstorm.com/packages/vX.X/install.sh.


For example, to install St2 $BRANCH the below URL is used:

   bash <(curl -sSL https://stackstorm.com/packages/$BRANCH/install.sh) --user=st2admin --password=Ch@ngeMe


This script will run the StackStorm Bootstrap script using $BRANCH after $TIMEOUT seconds.  Press CTRL-C to cancel the installation.

EOF

sleep $TIMEOUT
echo "Executing $URL" "$@"

bash <(curl -sSL "$URL") "$@"
