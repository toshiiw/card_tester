#!/bin/sh

ARGS=`getopt -o n -- "$@"`
eval set -- "$ARGS"
while true; do
    case "$1" in
    -n)
	dryrun=echo; shift; ;;
    --)
	shift; break; ;;
    *)
        echo 'Arg parse error'
        exit 1
    esac
done

TARGET=$1
if [ -z "$1" ]; then
    echo "Specify the device to test"
    exit 1
fi

$dryrun echo s3kure1234 > /tmp/key
$dryrun cryptsetup luksFormat --type luks2 $TARGET /tmp/key
$dryrun cryptsetup open --type luks2 --key-file /tmp/key $TARGET testcard 
$dryrun dd if=/dev/zero bs=256k status=progress of=/dev/mapper/testcard 
$dryrun cryptsetup close testcard

$dryrun cryptsetup open --type luks2 --key-file /tmp/key $TARGET testcard 
$dryrun dd bs=256k status=progress if=/dev/mapper/testcard |hexdump -C |head -100
$dryrun cryptsetup close testcard
