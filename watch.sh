#!/bin/bash
clear;

ruby ./build.rb;

while inotifywait -e close_write src/*; do clear; ruby ./build.rb; done