#!/bin/bash
clear;

while inotifywait -e close_write src/*; do clear; ./build.sh; done