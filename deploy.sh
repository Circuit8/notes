#!/bin/sh
set -e # exits if theres any error

./build.sh;

echo "Deploying..."

ruby ./deploy.rb;

echo "Deploy complete! http://circuit8.s3-website.eu-west-2.amazonaws.com/"