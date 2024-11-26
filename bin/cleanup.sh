#!/usr/bin/env bash

exists() {
  command -v $1 >/dev/null 2>&1
}

echo "Emptying Trash..."
rm -rf ~/.Trash/*

if exists 'brew' ; then
  echo "Cleaning up hombrew cache..."
  brew cleanup
fi

if exists 'foo' ; then
  # ToDo
  # Delete logs in /private/var/log/
  # only the ones that are rotated *.digit.* (recursively)
fi

# echo "Removing tmp files..."
# They take very small amount of space
# cd /private/var/tmp/; rm -rf *

# very aggressive
# rm -rf ~/Library/Caches/*


