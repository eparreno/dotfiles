#!/usr/bin/env bash

# Uninstall all gems

list=`gem list --no-versions`
for gem in $list; do
  gem uninstall $gem -aIx
done
gem list
gem install bundler
