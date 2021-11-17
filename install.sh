#!/bin/bash

CONFIG="$(dirname $0)"
cd $CONFIG

link_config() {
    SOURCE=$CONFIG/$1
    if [ -z "$2" ]; then
        DEST=$HOME/.config/$1
    else
        DEST=$2
    fi

    if [ -d "$DEST" ]; then
        echo "Directory already exists: $DEST"
        exit 1
    elif [ -f "$DEST" ]; then
        echo "File already exists: $DEST"
        exit 2
    elif [ -L "$DEST" ]; then
        if [ "$(readlink $DEST)" == "$SOURCE" ]; then
            echo "Link already exists: $DEST -> $SOURCE"
            exit 3
        else
            echo "Link already exists but does not match: $DEST -> $SOURCE got $(readlink $DEST)"
        fi
    else
        echo "Linking $DEST -> $SOURCE"
        ln -s $SOURCE $DEST
    fi
}

test() {
    EXPECT=$3
    msg="$(link_config "$1" "$2")"
    if [ "$msg" != "$EXPECT" ]; then
        echo "Fail:"
        echo expected
        echo -e "\t$EXPECT"
        echo got
        echo -e "\t$msg"
    else
        echo "Pass: $EXPECT"
    fi
}

# Test link dir exists
mkdir /tmp/link_test
test nvim /tmp/link_test "Directory already exists: /tmp/link_test"
rmdir /tmp/link_test

# Test link file exists
touch /tmp/link_test
test nvim /tmp/link_test "File already exists: /tmp/link_test"
rm /tmp/link_test

# Test link success
test nvim /tmp/link_test "Linking /tmp/link_test -> $CONFIG/nvim"
rm /tmp/link_test

# Test link link correct
ln -s $CONFIG/nvim /tmp/link_test
test nvim /tmp/link_test "Link already exists: /tmp/link_test -> $CONFIG/nvim"
rm /tmp/link_test

# Test link link incorrect
ln -s $CONFIG/wrong /tmp/link_test
test nvim /tmp/link_test "Link already exists but does not match: /tmp/link_test -> $CONFIG/nvim got $CONFIG/wrong"
rm /tmp/link_test

# Test link default dest
test link_test "" "Linking /home/thomas/.config/link_test -> $CONFIG/link_test"
rm $HOME/.config/link_test

#link_config nvim
#link_config Code/User
#link_home bashrc
