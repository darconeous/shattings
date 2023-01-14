#!/bin/sh

WORKING_DIR="`dirname $0`"

PASS_COUNT=0
FAIL_COUNT=0

test_cmd() {
  local cmd=$WORKING_DIR/$1
  local arg1=$2
  local arg2=$3
  local result="`$cmd "$arg1" 2>/dev/null`"
  #local result="`$cmd "$arg1"`"

  if test "$result" = "$arg2"
  then
    echo "PASS : $1 $arg1"
    PASS_COUNT=$((PASS_COUNT+1))
    true
  else
    echo "FAIL : $1 $arg1"
    echo "       Expected '$arg2', got '$result'."
    FAIL_COUNT=$((FAIL_COUNT+1))
    false
  fi
}

summarize() {
  echo
  echo "PASS: $PASS_COUNT"
  echo "FAIL: $FAIL_COUNT"

  test $FAIL_COUNT = 0
}

test_cmd callsign-to-ham-addr N6DRC 5CAC-70F8
test_cmd callsign-to-eui48 N6DRC 02:5C:AC:70:F8:00
test_cmd callsign-to-eui64 N6DRC 02:5C:AC:FF:FE:70:F8:00

test_cmd callsign-to-ham-addr KJ6QOH/P 4671-6CA0-E9C0
test_cmd callsign-to-eui48 KJ6QOH/P C2:46:71:6C:A0:E9
test_cmd callsign-to-eui64 KJ6QOH/P C2:46:71:FF:FE:6C:A0:E9
test_cmd mac-to-callsign C2:46:71:FF:FE:6C:A0:E9 KJ6QOH/P
test_cmd mac-to-callsign C2:46:71:6C:A0:E9 KJ6QOH/P

test_cmd callsign-to-ham-addr KJ6QOH-99 4671-6CA0-F344
test_cmd callsign-to-eui48 KJ6QOH-99 ""
test_cmd callsign-to-eui64 KJ6QOH-99 02:46:71:6C:A0:F3:44:00
test_cmd mac-to-callsign 02:46:71:6C:A0:F3:44:00 KJ6QOH-99

test_cmd callsign-to-ham-addr D9K 1EAB
test_cmd callsign-to-eui48 D9K 02:1E:AB:00:00:00
test_cmd callsign-to-eui64 D9K 02:1E:AB:FF:FE:00:00:00
test_cmd mac-to-callsign 02:1E:AB:FF:FE:00:00:00 D9K
test_cmd mac-to-callsign 02:1E:AB:00:00:00 D9K

test_cmd callsign-to-ham-addr NA1SS 57C4-79B8
test_cmd callsign-to-eui48 NA1SS 02:57:C4:79:B8:00
test_cmd callsign-to-eui64 NA1SS 02:57:C4:FF:FE:79:B8:00
test_cmd mac-to-callsign 02:57:C4:FF:FE:79:B8:00 NA1SS
test_cmd mac-to-callsign 02:57:C4:79:B8:00 NA1SS

test_cmd callsign-to-ham-addr VI2BMARC50 8B05-0E89-7118-A8C0
test_cmd callsign-to-eui48 VI2BMARC50 ""
test_cmd callsign-to-eui64 VI2BMARC50 C2:8B:05:0E:89:71:18:A8
test_cmd mac-to-callsign C2:8B:05:0E:89:71:18:A8 VI2BMARC50

test_cmd callsign-to-ham-addr N6DRC^M2 5CAC-711F-55C8
test_cmd callsign-to-eui48 N6DRC^M2 CA:5C:AC:71:1F:55
test_cmd callsign-to-eui64 N6DRC^M2 CA:5C:AC:FF:FE:71:1F:55

test_cmd callsign-to-ham-addr KJ6QOH-23 4671-6CA0-F226
test_cmd callsign-to-eui48 KJ6QOH-23 22:46:71:6C:A0:F2
test_cmd callsign-to-eui64 KJ6QOH-23 22:46:71:FF:FE:6C:A0:F2
test_cmd mac-to-callsign 22:46:71:FF:FE:6C:A0:F2 KJ6QOH-23
test_cmd mac-to-callsign 22:46:71:6C:A0:F2 KJ6QOH-23

test_cmd callsign-to-ham-addr KJ6QOH-2X 4671-6CA0-F220
test_cmd callsign-to-eui48 KJ6QOH-2X ""
test_cmd callsign-to-eui64 KJ6QOH-2X 02:46:71:6C:A0:F2:20:00
test_cmd mac-to-callsign 02:46:71:6C:A0:F2:20:00 KJ6QOH-2X

test_cmd callsign-to-ham-addr VI2BMARC50-1 8B05-0E89-7118-AECC
test_cmd callsign-to-eui48 VI2BMARC50-1 ""
test_cmd callsign-to-eui64 VI2BMARC50-1 BA:8B:05:0E:89:71:18:AE
test_cmd mac-to-callsign BA:8B:05:0E:89:71:18:AE VI2BMARC50-1

test_cmd callsign-to-ham-addr VI2BMARC50-X 8B05-0E89-7118-AEC8
test_cmd callsign-to-eui48 VI2BMARC50-X ""
test_cmd callsign-to-eui64 VI2BMARC50-X ""

test_cmd mac-to-callsign 00:00:00:00:00:00 ""
test_cmd mac-to-callsign 7F:B3:F6:84:0E:71 ""
test_cmd mac-to-callsign 74:B3:F6:84:0E:71 ""
test_cmd mac-to-callsign 70:B3:F6:84:0E:71 ""
test_cmd mac-to-callsign 7A:B3:F6:84:0E:71 "143UEFRF1"
test_cmd mac-to-callsign 72:FF:F6:84:0E:71 ""

test_cmd ham-addr-to-callsign FF02-ABCD ""

# TODO: Test escaping of 'N6DRC/MOBI-2'

summarize
