#!/bin/bash
# shellcheck disable=SC1090,SC2034
## These Folders Are For the Scripts in this Directory

## Script Location
SCRIPTDIR=$(dirname $0)

## Folder Name of Script
COMPLETEFOLDERPATH=$(realpath $SCRIPTDIR)
SCRIPTDIRNAME=$(echo "`basename $COMPLETEFOLDERPATH | cut -f 1 -d '.'`")

## Name Of Current Script
SCRIPTBASEFILENAME=$(echo "`basename $0 | cut -f 1 -d '.'`")

## Amount Of Folders Between
FOLDERDIFFDOTS="../"
FOLDERDIFF="$FOLDERDIFFDOTS"
SCRIPTFOLDERDIFF="$SCRIPTDIR/$FOLDERDIFF"

## Script Vars DIR
SCRIPTVARSDIR="$SCRIPTFOLDERDIFF"scriptvars/

## Static Vars Location
STATICVARS="$SCRIPTVARSDIR"staticvariables.sh

if
[[ -f $STATICVARS ]]
then
  source $STATICVARS
else
  echo "Static Vars File Missing, Exiting."
exit
fi

if
[[ ! -f $TEMPVARS ]]
then
  touch $TEMPVARS
fi

if
[[ -f $TEMPVARS ]]
then
  source $TEMPVARS
else
  echo "Temp Vars File Missing, Exiting."
  exit
fi

if
[[ ! -d $TOPLEVELSCRIPTSLOGSDIR ]]
then
  mkdir $TOPLEVELSCRIPTSLOGSDIR
fi

RECENTRUNLOGDIRECTORY="$TOPLEVELSCRIPTSLOGSDIR$SCRIPTDIRNAME/"
if
[[ ! -d $RECENTRUNLOGDIRECTORY ]]
then
  mkdir $RECENTRUNLOGDIRECTORY
fi

## Log File
RECENTRUN="$RECENTRUNLOGDIRECTORY$SCRIPTBASEFILENAME.md"
