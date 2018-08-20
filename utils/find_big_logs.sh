#!/bin/sh
find ./ -name '*.log' -size +100M | xargs du -h
