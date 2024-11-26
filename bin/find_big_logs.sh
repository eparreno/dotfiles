#!/bin/sh

# Finds any log file bigger than 100M
find ./ -name '*.log' -size +100M | xargs du -h
