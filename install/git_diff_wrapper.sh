#!/bin/bash
MELD=`which meld`
if [ -z $MELD ]; then
   echo "ERROR: Path to meld not found"
   exit 0;
fi

$MELD $2 $5
