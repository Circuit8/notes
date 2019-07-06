#!/bin/sh
set -e # exits if theres any error

# Rewrite all this in ruby for more control eh mate
echo "Building...";

rm -rf ./dist;
mkdir ./dist;
cp -r ./src/. ./dist;
find ./dist -iname "*.markdown" -type f -exec sh -c 'pandoc "${0}" -o "${0%.markdown}.html" -H ./src/header.html' {} \;
find ./dist -name "*.markdown" -type f -delete;

echo "Built!";