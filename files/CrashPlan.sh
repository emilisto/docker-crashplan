#!/bin/bash
TARGETDIR=/usr/local/crashplan

if [[ -f $TARGETDIR/install.vars ]]; then
        . $TARGETDIR/install.vars
else
        echo "Did not find $TARGETDIR/install.vars file."
fi

if [[ -f $TARGETDIR/bin/run.conf ]]; then
        . $TARGETDIR/bin/run.conf
else
        echo "Did not find $TARGETDIR/bin/run.conf file."
fi

cd $TARGETDIR

FULL_CP="$TARGETDIR/lib/com.backup42.desktop.jar:$TARGETDIR/lang"

$JAVACOMMON $SRV_JAVA_OPTS -classpath $FULL_CP com.backup42.service.CPService #> $TARGETDIR/log/engine_output.log 2> $TARGETDIR/log/engine_error.log

exit 0
