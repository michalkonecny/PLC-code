#!/bin/bash

set -e

function progress {
    echo "-------------------------------------------"
    echo "-------" $1
    echo "-------------------------------------------"
}

program_file=$1
if [ ! -r "$1" ]
then
    echo "You used $0 incorrectly.  Please call it with a valid Java file as follows:"
    echo "   bash $0 <file-name>.java"
else

    trap "progress 'cleaning up'; rm -f *.class" SIGHUP SIGINT SIGTERM EXIT

    class_name=${1/.java/}

    progress 'calling the compiler'
    # javac $1
    javac `find . -name '*.java'`
    progress 'compiler finished'
    set +e
    progress 'starting the program'
    java -ea $class_name
    progress 'program stopped'
fi

