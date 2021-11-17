#!/bin/bash

CONFIG="$(cd $(dirname $0); pwd)"
cd $CONFIG

while [ $# -gt 0 ]; do
    case "$1" in
        -h|--help) echo "Usage: $0 [-h|--help] [-f|--force]"; exit 0;;
        -f|--force) FORCE=1;;
        *);;
    esac
    shift
done

if [ ! -z "$FORCE" ]; then
    echo "Forcing install. This will only override links. Files and directories will be left untouched."
fi

make_link() {
    SOURCE=$1
    DEST=$2

    if [ -L "$DEST" ]; then
        if [ $FORCE ]; then
            echo "Linking $DEST -> $SOURCE with force"
            ln -sf $SOURCE $DEST
        else
            if [ "$(readlink $DEST)" == "$SOURCE" ]; then
                echo "Link already exists: $DEST -> $SOURCE"
            else
                echo "Link already exists but does not match: $DEST -> $SOURCE got $(readlink $DEST)"
            fi
        fi
    elif [ -d "$DEST" ]; then
        echo "Directory already exists: $DEST"
    elif [ -f "$DEST" ]; then
        echo "File already exists: $DEST"
    else
        echo "Linking $DEST -> $SOURCE"
        ln -s $SOURCE $DEST
    fi
}

link_config() {
    SOURCE=$CONFIG/$1
    if [ -z "$2" ]; then
        DEST=$HOME/.config/$1
    else
        DEST=$2
    fi

    make_link $SOURCE $DEST
}

link_home() {
    SOURCE=$CONFIG/home/$1
    if [ -z "$2" ]; then
        DEST=$HOME/.$1
    else
        DEST=$2
    fi

    make_link $SOURCE $DEST
}

copy_home() {
    SOURCE=$CONFIG/home/$1
    if [ -z "$2" ]; then
        DEST=$HOME/.$1
    else
        DEST=$2
    fi

    if [ ! -e "$DEST" ]; then
        echo "Copying: $SOURCE to $DEST"
        cp -r $SOURCE $DEST
    else
        echo "$DEST already exists, skipping"
    fi
}

test_link_config() {
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
}
# test_link_config

link_config nvim
link_home bashrc
link_home gitconfig
copy_home gitconfig_user
link_home clang-format
link_home inputrc
link_home tmux.conf
link_home templates
