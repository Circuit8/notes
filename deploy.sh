#!/bin/sh

set -e;

gem install bundler;
bundle;
ruby build.rb;
