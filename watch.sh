#!/bin/bash
clear;

while inotifywait -e close_write src/*; do clear; ruby ./build.rb; done