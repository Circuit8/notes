#!/bin/bash
clear;

postit build;

while inotifywait -e close_write ./src/**/*; do clear; postit build; done