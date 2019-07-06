#!/bin/sh
set -e # exits if theres any error

./build.sh;

echo "Deploying..."

ruby ./deploy.rb;

echo "Deploy complete! https://circuit8.github.io/"