#!/bin/sh
set -e

if [ "$1" = "write" ]; then
  echo $2 > $3

  echo "{
    what: filesize
    path: $3
    size: $(stat -c'%s' $3)
    metric_type: guage
  }" > /tmp/metrics/2.0

else if [ "$1" = "read" ]; then
  echo "{
    what: filesize
    path: $2
    size: $(stat -c'%s' $2)
    metric_type: guage
  }" > /tmp/metrics/2.0

  cat $2

else if [ "$1" = "size" ]; then
  stat -c'%s' $2

else if [ "$1" = "exists" ]; then
  if [ -f $2 ] || [ -d $2 ]; then
     echo 'true'
  else
    echo 'false'
  fi

else if [ "$1" = "type" ]; then
  if [ -f $2 ]; then
    echo 'file'
  else if [ -f $2 ]; then
    echo 'folder'
  else
    exit 0
  fi

fi
