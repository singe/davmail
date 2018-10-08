#!/bin/sh
#
# Usage: davmail [</path/to/davmail.properties>]
#
# In case of SWT crash under JDK 9, uninstall SWT or remove the second case below
#
BASE=`dirname $0`
JAVA_OPTS="-Xmx512M -Dsun.net.inetaddr.ttl=60"
if [ -f $BASE/davmail.jar ]; then
    # this is the platform independent package
    exec java $JAVA_OPTS -cp davmail.jar:lib/* davmail.DavGateway "$@"
elif [ -f /usr/share/java/swt.jar ]; then
    # standard install with SWT
    export LD_LIBRARY_PATH=/usr/lib/jni
    exec java $JAVA_OPTS -cp /usr/share/davmail/davmail.jar:/usr/share/java/swt.jar:/usr/share/davmail/lib/* davmail.DavGateway "$@"
else
    exec java $JAVA_OPTS -cp /usr/share/davmail/davmail.jar:/usr/share/davmail/lib/* davmail.DavGateway "$@"
fi
