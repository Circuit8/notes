#!/bin/sh

set -e # exits immediately on error. Prevents all hell from breaking loose. eg when in the wrong directory

ruby -run -e httpd ./dist;